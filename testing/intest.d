#!/usr/bin/dmd -run

module mtest;

import metus.dncurses.dncurses;

void main() {
	initscr();
	scope(exit) endwin();

	static if(1) {
		Window ansWin = new Window(stdwin, 3, stdwin.max.x, stdwin.max.y-2, 0, Positioning.Relative);
	} else {
		Window ansWin = stdwin.derwin(3, stdwin.max.x, stdwin.max.y-2, 0);
	}

	ansWin.border();

	stdwin.put(Pos(stdwin.max.y/2, (stdwin.max.x-16)/2), "Enter a string: ");

	auto str = stdwin.getstr(80);
	ansWin.put(Pos(1,1), ACS.lantern, ": You Entered: ", str.bold);
	stdwin.touch();
	stdwin.getch();
}
