from dataclasses import dataclass, field
from typing import Dict, List
import json
import subprocess


@dataclass
class Package:
    name: str
    reason: str
    category: str
    subcategory: str = ""  # For packages in bspwm or hyprland
    selected: bool = field(default=False)  # Track selection state
    installed: bool = field(default=False)  # Track installation status


class PackageManager:
    def __init__(self, config_path: str):
        self.config_path = config_path
        self.packages: Dict[str, List[Package]] = {}
        self._load_config()
        self._check_installed_packages()

    def _load_config(self) -> None:
        """Load and parse the JSON configuration file."""
        with open(self.config_path, 'r') as f:
            config = json.load(f)

        self.packages['base'] = [
            Package(name=pkg['name'], reason=pkg['reason'], category='base')
            for pkg in config.get('base', [])
        ]

        self.packages['xorg'] = [
            Package(name=pkg['name'], reason=pkg['reason'], category='xorg')
            for pkg in config.get('xorg', {}).get('packages', [])
        ]

        self.packages['bspwm'] = [
            Package(name=pkg['name'], reason=pkg['reason'], category='xorg', subcategory='bspwm')
            for pkg in config.get('xorg', {}).get('bspwm', [])
        ]

        self.packages['wayland'] = [
            Package(name=pkg['name'], reason=pkg['reason'], category='wayland')
            for pkg in config.get('wayland', {}).get('packages', [])
        ]

        self.packages['hyprland'] = [
            Package(name=pkg['name'], reason=pkg['reason'], category='wayland', subcategory='hyprland')
            for pkg in config.get('wayland', {}).get('hyprland', [])
        ]

    def _check_installed_packages(self) -> None:
        """Check which packages are already installed on the system."""
        try:
            # Get list of all installed packages
            result = subprocess.run(
                ["pacman", "-Q"],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            
            if result.returncode != 0:
                print(f"Warning: Failed to get installed packages: {result.stderr}")
                return
                
            # Parse the output to get package names
            installed_packages = set()
            for line in result.stdout.splitlines():
                if line:
                    pkg_name = line.split()[0]
                    installed_packages.add(pkg_name)
            
            # Mark packages as installed and selected by default
            for package in self.get_all_packages():
                if package.name in installed_packages:
                    package.installed = True
                    package.selected = True
                    
        except Exception as e:
            print(f"Warning: Failed to check installed packages: {e}")

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
