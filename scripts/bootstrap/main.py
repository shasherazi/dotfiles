#!/usr/bin/env python
import inquirer
import json

# get packages from json file
with open("packages.json") as f:
    packages = json.load(f)


def print_package_list(packages):
    for category, package_list in packages.items():
        # Print category name in bold and green
        print(category.upper())
        for package in package_list:
            # Print each package name indented
            print(
                f"  - {package['name']} ({package['package_name']}) ({package['description']})")
        print()  # empty line for better readibility


print_package_list(packages)
