import metus.dncurses.dncurses;

void main(string[] args) {
	initscr();
	scope(exit) endwin();

	mode = CBreak();
	stdwin.keypad = true;

	with(stdwin) {
		put(Pos(5,5));
		auto x = getstr();
		put(Pos(6,5),x);
		getch();
	}
}
