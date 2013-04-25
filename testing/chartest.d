#!/usr/bin/rdmd

import std.string;
import metus.dncurses.dncurses;

void main() {
	initscr();
	scope(exit) endwin();

	echo = false;
	stdwin.scrollok=true;
	stdwin.keypad=true;
	mode = Raw();

	while(1) {
		auto c = stdwin.getch();
		if(c == Key.F5) {
			stdwin.put("A winner is you!\n\n");
			stdwin.getch();
			return;
		} else {
			stdwin.put("0x", format("%08x",c), '\n');
		}
	}

}
