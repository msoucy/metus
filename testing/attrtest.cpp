#include <iostream>
#include <ncurses.h>
using namespace std;

int main() {
	initscr();
	start_color();

	mvprintw(4,5, "Hello, world!");
	attrset(A_STANDOUT);
	mvprintw(4,30, "Hello, standout!");
	attrset(A_UNDERLINE);
	mvprintw(5,5, "Hello, underline!");
	attrset(A_REVERSE);
	mvprintw(5,30, "Hello, reversed!");
	attrset(A_BLINK);
	mvprintw(6,5, "Hello, blink!");
	attrset(A_DIM);
	mvprintw(6,30, "Hello, dim!");
	attrset(A_BOLD);
	mvprintw(7,5, "Hello, bold!");
	attrset(A_STANDOUT | A_BOLD | A_BLINK | A_UNDERLINE);
	mvprintw(7,30, "Hello, mixed!");

	getch();
	endwin();
	return 0;
}
