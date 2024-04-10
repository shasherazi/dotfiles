#!/usr/bin/env python
import inquirer
import json

# get packages from json file
with open("packages.json") as f:
    packages = json.load(f)

# browsers
browsers = inquirer.Checkbox(
    "browsers",
    message="What browser do you want to use? (Press <space> to select, <enter> to finish)",
    choices=[
        (package["name"], package["package_name"]) for package in packages["browsers"]
    ],
    default=["firefox"],
)

# dev
dev = inquirer.Checkbox(
    "dev",
    message="What dev package do you want to install? (Press <space> to select, <enter> to finish)",
    choices=[(package["name"], package["package_name"]) for package in packages["dev"]],
    default=[package["package_name"] for package in packages["dev"]],
)

# socials
socials = inquirer.Checkbox(
    "socials",
    message="What social media do you want to use? (Press <space> to select, <enter> to finish)",
    choices=[
        (package["name"], package["package_name"]) for package in packages["socials"]
    ],
    default=["webcord-bin"],
)

# miscellaneous
miscellaneous = inquirer.Checkbox(
    "miscellaneous",
    message="What miscellanous package do you want to install? (Press <space> to select, <enter> to finish)",
    choices=[
        (package["name"], package["package_name"])
        for package in packages["miscellaneous"]
    ],
    default=[package["package_name"] for package in packages["miscellaneous"]],
)

questions = [browsers, dev, socials, miscellaneous]

answers = inquirer.prompt(questions)
print(answers)
