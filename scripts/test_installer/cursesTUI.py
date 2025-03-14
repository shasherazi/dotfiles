import curses
import curses.ascii
from packageInstaller import PackageManager


class SimplePackageManagerTUI:
    def __init__(self, config_path: str):
        self.package_manager = PackageManager(config_path)
        self.packages = self.package_manager.get_all_packages()
        self.current_index = 0
        self.top_line = 0

    def get_display_text(self, package) -> str:
        """Format the package information for display"""
        checkbox = "[x]" if package.selected else "[ ]"
        category = f"{
            package.category}/{package.subcategory}" if package.subcategory else package.category
        return f"{checkbox} {package.name:<30} {category:<20} {package.reason}"

    def handle_page_up(self, visible_lines: int) -> None:
        """Handle Page Up key with proper bounds checking"""
        new_index = max(0, self.current_index - visible_lines)
        self.current_index = new_index
        self.top_line = max(0, new_index - (visible_lines - 1))

    def handle_page_down(self, visible_lines: int) -> None:
        """Handle Page Down key with proper bounds checking"""
        max_index = len(self.packages) - 1
        new_index = min(max_index, self.current_index + visible_lines)
        self.current_index = new_index
        if new_index == max_index:
            self.top_line = max(0, max_index - visible_lines + 1)
        else:
            self.top_line = max(0, new_index - (visible_lines - 1))

    def save_install_command(self) -> None:
        """Save the install command to a file"""
        command = self.package_manager.get_install_command()
        if command:  # Only write if there are selected packages
            with open('install_command', 'w') as f:
                f.write(command + '\n')

    def run(self, stdscr):
        # Setup
        curses.curs_set(0)  # Hide cursor
        stdscr.keypad(True)  # Enable special keys

        while True:
            # Get window dimensions
            max_y, max_x = stdscr.getmaxyx()
            visible_lines = max_y - 2  # Leave room for header and footer

            # Clear screen
            stdscr.clear()

            # Draw packages
            for i in range(visible_lines):
                package_index = self.top_line + i
                if package_index >= len(self.packages):
                    break

                # Highlight current line
                if package_index == self.current_index:
                    attr = curses.A_REVERSE
                else:
                    attr = curses.A_NORMAL

                package = self.packages[package_index]
                display_text = self.get_display_text(package)

                # Truncate if necessary to avoid screen overflow
                if len(display_text) > max_x - 1:
                    display_text = display_text[:max_x - 4] + "..."

                stdscr.addstr(i + 1, 0, display_text, attr)

            # Handle input
            key = stdscr.getch()

            if key == curses.KEY_UP and self.current_index > 0:
                self.current_index -= 1
                if self.current_index < self.top_line:
                    self.top_line = self.current_index

            elif key == curses.KEY_DOWN and self.current_index < len(self.packages) - 1:
                self.current_index += 1
                if self.current_index >= self.top_line + visible_lines:
                    self.top_line = self.current_index - visible_lines + 1

            elif key == curses.KEY_PPAGE:  # Page Up
                self.handle_page_up(visible_lines)

            elif key == curses.KEY_NPAGE:  # Page Down
                self.handle_page_down(visible_lines)

            elif key == curses.KEY_HOME:
                self.current_index = 0
                self.top_line = 0

            elif key == curses.KEY_END:
                self.current_index = len(self.packages) - 1
                self.top_line = max(0, len(self.packages) - visible_lines)

            elif key == ord(' '):  # Space key
                # Toggle selection
                current_package = self.packages[self.current_index]
                self.package_manager.toggle_package(current_package.name)

                # Move down if possible
                if self.current_index < len(self.packages) - 1:
                    self.current_index += 1
                    if self.current_index >= self.top_line + visible_lines:
                        self.top_line = self.current_index - visible_lines + 1

            elif key == ord('q'):  # Quit
                self.save_install_command()  # Save command before quitting
                break

            # Update status line
            selected_count = len(self.package_manager.get_selected_packages())
            total_count = len(self.packages)
            status_line = f" Selected: {
                selected_count}/{total_count} | Press 'q' to quit "
            try:
                stdscr.addstr(0, 0, status_line, curses.A_REVERSE)
            except curses.error:
                pass

            stdscr.refresh()


def main(config_path: str):
    app = SimplePackageManagerTUI(config_path)
    curses.wrapper(app.run)


if __name__ == "__main__":
    main("packages.json")
