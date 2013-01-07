#!/usr/bin/dmd -run

import metus.dncurses.dncurses;

void colortest() {
	foreach(short b ; 0..8) {
		stdwin.put(bg(b));
		foreach(short f ; 0..8) {
			stdwin.put("A".fg(f));
		}
	}
}

void main() {
	initscr();
	scope(exit) endwin();
	initColor();

	stdwin.put(
		Pos(4,5), "Hello, world!",
		Pos(4,30), "Hello, standout!".standout,
		Pos(5,5), "Hello, underline!".underline,
		Pos(5,30), "Hello, reversed!".invert,
		Pos(6,5), "Hello, blink!".blink,
		Pos(6,30), "Hello, dim!".dim,
		Pos(7,5), "Hello, bold!".bold,
		Pos(7,30), "Hello, mixed!".standout.bold.blink.underline,
		bold,
		Pos(8,5), "Hello, defaultbold!",
		Pos(8,30), "Hello, nodefaultbold!".nobold,
		Pos(10,5), nobold
	);
	colortest();
	stdwin.put(Pos(11,5), bold);
	colortest();
	stdwin.put(Pos(12,5), nobold, invert);
	colortest();
	stdwin.put(Pos(13,5), bold, invert);
	colortest();
	stdwin.put(attrclear);
	stdwin.getch();
	stdwin.bkgd('-', bg(Color.RED));
	stdwin.bkgd('&', bg(Color.GREEN));
	stdwin.clear();
	stdwin.put(Pos(14,5), "Hello, world!");
	//stdwin.put(stdwin.max, '-');

	stdwin.getch();
}
