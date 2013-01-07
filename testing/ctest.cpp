#include <ncurses.h>

int main() {
	initscr();
	start_color();
	printw("%d", COLOR_PAIRS);
	getch();
	endwin();
	return 0;
}