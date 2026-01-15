#!/usr/bin/env python3

import curses
import curses.ascii
import os
import subprocess
from packageInstaller import PackageManager


class SimplePackageManagerTUI:
    def __init__(self, config_path: str):
        self.package_manager = PackageManager(config_path)
        self.packages = self.package_manager.get_all_packages()
        self.current_index = 0
        self.top_line = 0
        self.show_installed_only = False
        self.filter_text = ""
        self.categories = self.get_unique_categories()
        self.selected_category = "all"
        self.filtered_packages = self.packages

    def get_unique_categories(self):
        """Get all unique categories from packages"""
        categories = set(["all"])
        for package in self.packages:
            categories.add(package.category)
            if package.subcategory:
                categories.add(package.subcategory)
        return sorted(list(categories))

    def get_display_text(self, package) -> str:
        """Format the package information for display"""
        checkbox = "[x]" if package.selected else "[ ]"
        installed = "[INSTALLED]" if package.installed else ""
        category = f"{package.category}/{package.subcategory}" if package.subcategory else package.category
        return f"{checkbox} {package.name:<25} {installed:<12} {category:<15} {package.reason}"

    def filter_packages(self):
        """Filter packages based on current criteria"""
        self.filtered_packages = []
        for package in self.packages:
            # Filter by text
            name_match = self.filter_text.lower() in package.name.lower()
            reason_match = self.filter_text.lower() in package.reason.lower()
            text_match = name_match or reason_match
            
            # Filter by installed status
            installed_match = not self.show_installed_only or package.installed
            
            # Filter by category
            category_match = (self.selected_category == "all" or 
                             package.category == self.selected_category or 
                             package.subcategory == self.selected_category)
            
            if text_match and installed_match and category_match:
                self.filtered_packages.append(package)
        
        # Reset cursor position
        if self.filtered_packages:
            self.current_index = min(self.current_index, len(self.filtered_packages) - 1)
        else:
            self.current_index = 0
        self.top_line = min(self.top_line, self.current_index)

    def handle_page_up(self, visible_lines: int) -> None:
        """Handle Page Up key with proper bounds checking"""
        new_index = max(0, self.current_index - visible_lines)
        self.current_index = new_index
        self.top_line = max(0, new_index - (visible_lines - 1))

    def handle_page_down(self, visible_lines: int) -> None:
        """Handle Page Down key with proper bounds checking"""
        max_index = len(self.filtered_packages) - 1
        if max_index < 0:
            return
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
            
            # Make it executable
            os.chmod('install_command', 0o755)
            return True
        return False

    def run(self, stdscr):
        # Setup
        curses.curs_set(0)  # Hide cursor
        stdscr.keypad(True)  # Enable special keys
        
        # Initialize colors if the terminal supports them
        if curses.has_colors():
            curses.start_color()
            curses.init_pair(1, curses.COLOR_GREEN, curses.COLOR_BLACK)  # For installed packages
            curses.init_pair(2, curses.COLOR_YELLOW, curses.COLOR_BLACK)  # For selected packages
            curses.init_pair(3, curses.COLOR_BLACK, curses.COLOR_WHITE)  # For highlighted row

        # Filter packages initially
        self.filter_packages()

        while True:
            # Get window dimensions
            max_y, max_x = stdscr.getmaxyx()
            visible_lines = max_y - 2  # Leave room for header and footer

            # Clear screen
            stdscr.clear()

            # Draw header
            header = f" Package Manager | {len(self.filtered_packages)} packages | Filter: {self.filter_text} | Category: {self.selected_category}"
            try:
                if curses.has_colors():
                    stdscr.addstr(0, 0, header, curses.color_pair(3))
                else:
                    stdscr.addstr(0, 0, header, curses.A_REVERSE)
            except curses.error:
                pass

            # Draw packages
            for i in range(visible_lines):
                package_index = self.top_line + i
                if package_index >= len(self.filtered_packages):
                    break

                # Get package at this index
                if not self.filtered_packages:
                    continue
                package = self.filtered_packages[package_index]
                
                # Prepare display text
                display_text = self.get_display_text(package)

                # Truncate if necessary to avoid screen overflow
                if len(display_text) > max_x - 1:
                    display_text = display_text[:max_x - 4] + "..."

                # Determine attributes based on package state
                if package_index == self.current_index:
                    attr = curses.A_REVERSE
                else:
                    attr = curses.A_NORMAL

                try:
                    # Add the package line with appropriate attributes
                    stdscr.addstr(i + 1, 0, display_text, attr)
                    
                    # Overlay additional color indicators if colors are supported
                    if curses.has_colors() and package_index != self.current_index:
                        if package.installed:
                            # Color the [INSTALLED] text
                            installed_pos = display_text.find("[INSTALLED]")
                            if installed_pos > 0:
                                stdscr.addstr(i + 1, installed_pos, "[INSTALLED]", curses.color_pair(1))
                except curses.error:
                    pass

            # Draw footer with help text
            footer = " SPACE:Toggle | f:Filter | c:Category | i:Installed | a:Select All | n:None | q:Quit "
            try:
                if curses.has_colors():
                    stdscr.addstr(max_y - 1, 0, footer, curses.color_pair(3))
                else:
                    stdscr.addstr(max_y - 1, 0, footer, curses.A_REVERSE)
            except curses.error:
                pass

            # Handle input
            try:
                key = stdscr.getch()
            except:
                continue

            if key == curses.KEY_UP:
                if self.current_index > 0:
                    self.current_index -= 1
                    if self.current_index < self.top_line:
                        self.top_line = self.current_index

            elif key == curses.KEY_DOWN:
                if self.filtered_packages and self.current_index < len(self.filtered_packages) - 1:
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
                if self.filtered_packages:
                    self.current_index = len(self.filtered_packages) - 1
                    self.top_line = max(0, len(self.filtered_packages) - visible_lines)

            elif key == ord(' '):  # Space key
                # Toggle selection
                if self.filtered_packages:
                    current_package = self.filtered_packages[self.current_index]
                    self.package_manager.toggle_package(current_package.name)

                    # Move down if possible
                    if self.current_index < len(self.filtered_packages) - 1:
                        self.current_index += 1
                        if self.current_index >= self.top_line + visible_lines:
                            self.top_line = self.current_index - visible_lines + 1

            elif key == ord('f'):  # Filter by text
                # Prompt for filter text
                curses.echo()
                stdscr.addstr(max_y - 1, 0, "Filter: " + " " * (max_x - 8))
                stdscr.addstr(max_y - 1, 0, "Filter: ")
                self.filter_text = stdscr.getstr(max_y - 1, 8, 50).decode('utf-8')
                curses.noecho()
                self.filter_packages()

            elif key == ord('c'):  # Filter by category
                # Show category menu
                categories_menu = []
                for category in self.categories:
                    categories_menu.append(f"{category}")
                
                # Create a new window for the menu
                menu_height = min(len(categories_menu) + 2, max_y - 4)
                menu_width = 30
                menu_win = curses.newwin(menu_height, menu_width, (max_y - menu_height) // 2, (max_x - menu_width) // 2)
                menu_win.keypad(True)
                
                # Display menu
                menu_index = 0
                while True:
                    menu_win.clear()
                    menu_win.box()
                    menu_win.addstr(0, 1, "Select Category")
                    
                    for i in range(min(menu_height - 2, len(categories_menu))):
                        menu_item = categories_menu[i]
                        if i == menu_index:
                            menu_win.addstr(i + 1, 1, menu_item, curses.A_REVERSE)
                        else:
                            menu_win.addstr(i + 1, 1, menu_item)
                    
                    menu_win.refresh()
                    menu_key = menu_win.getch()
                    
                    if menu_key == curses.KEY_UP and menu_index > 0:
                        menu_index -= 1
                    elif menu_key == curses.KEY_DOWN and menu_index < len(categories_menu) - 1:
                        menu_index += 1
                    elif menu_key == 10:  # Enter
                        self.selected_category = self.categories[menu_index]
                        self.filter_packages()
                        break
                    elif menu_key == 27:  # Escape
                        break
                
                # Refresh main screen
                stdscr.clear()
                stdscr.refresh()

            elif key == ord('i'):  # Toggle show installed only
                self.show_installed_only = not self.show_installed_only
                self.filter_packages()

            elif key == ord('a'):  # Select all visible packages
                for package in self.filtered_packages:
                    package.selected = True

            elif key == ord('n'):  # Deselect all visible packages
                for package in self.filtered_packages:
                    package.selected = False

            elif key == ord('s'):  # Save install command
                if self.save_install_command():
                    # Show success message
                    stdscr.addstr(max_y - 1, 0, "Install command saved to './install_command'" + " " * 20)
                    stdscr.refresh()
                    curses.napms(1500)  # Wait 1.5 seconds

            elif key == ord('r'):  # Run install command
                if self.save_install_command():
                    # Restore terminal to normal mode
                    curses.endwin()
                    
                    # Run the install command
                    print("Running install command...")
                    try:
                        subprocess.run("./install_command", shell=True)
                    except Exception as e:
                        print(f"Error: {e}")
                    
                    print("\nPress Enter to return to package manager...")
                    input()
                    
                    # Reload installed packages
                    self.package_manager._check_installed_packages()
                    self.filter_packages()

            elif key == ord('q'):  # Quit
                if self.save_install_command():
                    break
                
                # Confirm quit
                stdscr.addstr(max_y - 1, 0, "Save changes? (y/n)" + " " * (max_x - 19))
                stdscr.refresh()
                confirm = stdscr.getch()
                if confirm in (ord('y'), ord('Y')):
                    break
                elif confirm in (ord('n'), ord('N')):
                    break

            stdscr.refresh()


def main(config_path: str):
    app = SimplePackageManagerTUI(config_path)
    curses.wrapper(app.run)


if __name__ == "__main__":
    import sys
    config_path = sys.argv[1] if len(sys.argv) > 1 else "packages.json"
    main(config_path)
