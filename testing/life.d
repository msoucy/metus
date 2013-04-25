#!/usr/bin/rdmd

module life;

import metus.dncurses.dncurses;
import std.algorithm;

class Cellular {
private:
	// Data
	enum Change {Kill, Birth=1<<0, Survive=1<<1};
	ubyte[9] m_rules;
	bool[] m_data;
	uint m_rows, m_cols;

	uint getIndex(uint row, uint col) {
		return (row*m_cols+col);
	}

	ubyte countSurrounding(uint row, uint col) {
		ubyte ret = 0;
		if(row>0) {
			ret += cast(bool)m_data[getIndex(row-1,col)];
			if(col>0) {
				ret += cast(bool)m_data[getIndex(row-1,col-1)];
			}
			if(col+1<m_cols) {
				ret += cast(bool)m_data[getIndex(row-1,col+1)];
			}
		}
		if(row+1<m_rows) {
			ret += cast(bool)m_data[getIndex(row+1,col)];
			if(col>0) {
				ret += cast(bool)m_data[getIndex(row+1,col-1)];
			}
			if(col+1<m_cols) {
				ret += cast(bool)m_data[getIndex(row+1,col+1)];
			}
		}
		if(col>0) {
			ret += cast(bool)m_data[getIndex(row,col-1)];
		}
		if(col+1<m_cols) {
			ret += cast(bool)m_data[getIndex(row,col+1)];
		}
		return ret;
	}
public:
	this(uint rows, uint cols, string rules="B3/S23") {
		m_rows = rows;
		m_cols = cols;
		m_data = new bool[m_rows*m_cols];
		bool slash=false;
		foreach(c;rules) with(Change) {
			if(c <= '9' && c >= '0') {
				m_rules[c-'0'] |= slash?Survive:Birth;
			} else if(c=='/' || c=='\\') {
				slash = true;
			}
		}
	}
	ref bool opIndex(uint row, uint col) {
		return m_data[getIndex(row,col)];
	}
	void update() {
		bool[] newData = m_data.dup;
		foreach(r;0..m_rows) {
			foreach(c;0..m_cols) {
				ubyte rule = m_rules[countSurrounding(r,c)];
				with(Change)
				if(rule&Birth) {
					newData[getIndex(r,c)] = true;
				} else if(rule==Kill) {
					newData[getIndex(r,c)] = false;
				}
			}
		}
		m_data = newData;
	}
	void display() {
		stdwin.erase();
		stdwin.put(Pos(0,0));
		foreach(b; m_data) {
			try {
				stdwin.put(b?'#':' ');
			} catch(NCursesException e) {
				// Couldn't place the character, but this always happens at the
			}
		}
	}
	void rules() {
		stdwin.erase();
		stdwin.put(Pos(1,1), "Birth", Pos(1,10));
		foreach(i,rule;m_rules) {
			if(rule&Change.Birth) stdwin.put(cast(char)(i+'0'));
		}
		stdwin.put(Pos(2,1), "Survive", Pos(2,10));
		foreach(i,rule;m_rules) {
			if(rule&Change.Survive) stdwin.put(cast(char)(i+'0'));
		}
		stdwin.getch();
		stdwin.erase();
		display();
	}
}

void main() {
	initscr();
	scope(exit) endwin();

	echo(false);
	scope(exit) echo(true);

	stdwin.timeout(50);
	stdwin.keypad(true);

	int row = stdwin.max.y/2;
	int col = stdwin.max.x/2;
	bool play = false;
	Cellular game = new Cellular(stdwin.max.y+1, stdwin.max.x+1);

	mainLoop:
	while(1) {
		stdwin.put(Pos(row,col));
		auto c = stdwin.getch();
		//stdwin.erase();
		switch(c) {
			case Key.Up, 'w': {
				if(row > 0) row--;
				break;
			}
			case Key.Left, 'a': {
				if(col > 0) col--;
				break;
			}
			case Key.Down, 's': {
				if(row < stdwin.max.y) row++;
				break;
			}
			case Key.Right, 'd': {
				if(col < stdwin.max.x) col++;
				break;
			}
			case 'e': {
				// Flip a cell
				game[row,col] ^= true;
				break;
			}
			case 'r': {
				// Single update
				if(!play) game.update();
				break;
			}
			case '?': {
				// Show rules
				game.rules();
				break;
			}
			case Key.F5: {
				flash();
				break;
			}
			case ' ': {
				// Play/pause
				play ^= true;
				flash();
				break;
			}
			case 'q': {
				break mainLoop;
			}
			default: {
				break;
			}
		}
		if(play) {
			game.update();
		}
		game.display();
	}
}
