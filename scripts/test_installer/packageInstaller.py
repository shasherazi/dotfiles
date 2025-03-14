from dataclasses import dataclass, field
from typing import Dict, List
import json


@dataclass
class Package:
    name: str
    reason: str
    category: str
    subcategory: str = ""  # For packages in bspwm or hyprland
    selected: bool = field(default=False)  # Track selection state


class PackageManager:
    def __init__(self, config_path: str):
        self.config_path = config_path
        self.packages: Dict[str, List[Package]] = {}
        self._load_config()

    def _load_config(self) -> None:
        """Load and parse the JSON configuration file."""
        with open(self.config_path, 'r') as f:
            config = json.load(f)

        # Handle base packages
        self.packages['base'] = [
            Package(name=pkg['name'], reason=pkg['reason'], category='base')
            for pkg in config['base']
        ]

        # Handle xorg packages
        self.packages['xorg'] = [
            Package(name=pkg['name'], reason=pkg['reason'], category='xorg')
            for pkg in config['xorg']['packages']
        ]

        # Handle xorg/bspwm packages
        self.packages['bspwm'] = [
            Package(name=pkg['name'], reason=pkg['reason'],
                    category='xorg', subcategory='bspwm')
            for pkg in config['xorg']['bspwm']
        ]

        # Handle wayland packages
        self.packages['wayland'] = [
            Package(name=pkg['name'], reason=pkg['reason'], category='wayland')
            for pkg in config['wayland']['packages']
        ]

        # Handle wayland/hyprland packages
        self.packages['hyprland'] = [
            Package(name=pkg['name'], reason=pkg['reason'],
                    category='wayland', subcategory='hyprland')
            for pkg in config['wayland']['hyprland']
        ]

    def get_all_packages(self) -> List[Package]:
        """Get all packages from all categories."""
        all_packages = []
        for packages in self.packages.values():
            all_packages.extend(packages)
        return all_packages

    def get_packages_by_category(self, category: str, include_subcategories: bool = True) -> List[Package]:
        """Get packages for a specific category."""
        if category not in self.packages:
            return []

        packages = self.packages[category]

        if include_subcategories:
            if category == 'xorg':
                packages += self.packages['bspwm']
            elif category == 'wayland':
                packages += self.packages['hyprland']

        return packages

    def toggle_package(self, package_name: str) -> None:
        """Toggle the selection state of a package."""
        for package in self.get_all_packages():
            if package.name == package_name:
                package.selected = not package.selected
                break

    def get_selected_packages(self) -> List[Package]:
        """Get all selected packages."""
        return [pkg for pkg in self.get_all_packages() if pkg.selected]

    def select_category(self, category: str, include_subcategories: bool = True) -> None:
        """Select all packages in a category."""
        packages = self.get_packages_by_category(
            category, include_subcategories)
        for package in packages:
            package.selected = True

    def deselect_category(self, category: str, include_subcategories: bool = True) -> None:
        """Deselect all packages in a category."""
        packages = self.get_packages_by_category(
            category, include_subcategories)
        for package in packages:
            package.selected = False

    def get_install_command(self) -> str:
        """Generate the installation command for selected packages."""
        selected_packages = [pkg.name for pkg in self.get_selected_packages()]
        if not selected_packages:
            return ""

        packages_str = " ".join(sorted(selected_packages))
        return f"yay -Syu --needed --noconfirm {packages_str}"


# Example usage:
if __name__ == "__main__":
    # Test the class
    pm = PackageManager("packages.json")

    # Print all packages
    print("All packages:")
    for package in pm.get_all_packages():
        print(f"{package.name} ({package.category}/{package.subcategory if package.subcategory else ''})")

    # Test selection
    pm.toggle_package("firefox")
    pm.toggle_package("neovim")

    # Print selected packages
    print("\nSelected packages:")
    for package in pm.get_selected_packages():
        print(package.name)

    # Print install command
    print("\nInstall command:")
    print(pm.get_install_command())
