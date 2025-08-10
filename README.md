# Universal User Repository (UUR)

**UUR** (Universal User Repository) is a lightweight package manager designed to install and manage software from multiple sources, with fallback to native package managers.

## Features

* Install packages from UUR repositories
* Fallback to native package managers (Pacman/Yay for Arch, APT for Ubuntu/Termux)
* Package upgrades
* Repository updates
* Cross-distro support: **Arch**, **Ubuntu**, **Termux**
* Minimal dependencies

## Installation

Run `sudo make install`, which will:
* Install required dependencies using `./deps`
* Install `UUR` by copying the `uur` executable to `/usr/bin/uur`

## Usage

```bash
uur update               # Update repositories
uur list                 # List available packages
uur install <package>    # Install a package
uur upgrade              # Upgrade all installed packages
uur native <package>     # Install using native package manager
uur --help               # Display help
```

### Example

```bash
# Update repos
uur update

# Install the bootstrap package
uur install main/bootstrap

# List installed packages
uur list -i
```

## UUR Repositories

By default, UUR automatically adds the main repository:

```
https://github.com/Federico-Ciuffardi/uur-repo-main
```

### How to create and add a new UUR repository

#### Create the repository

Create a new Git repository on GitHub, GitLab, or your preferred Git hosting platform. This repo will hold your package directories and metadata.

You should name the repo following the pattern: `uur-repo-<repo name>`.
**Note:** The `<repo name>` cannot contain the dash (`-`) character.

The repository structure and packages should look like this:

```
repo-name/
├── package1/
│   ├── imake           # Build script (allows user interaction)
│   ├── make            # Build script (doesn't allow user interaction)
│   ├── git             # URL of the upstream Git source (optional)
│   ├── ver             # Version identifier (used if no git file)
│   ├── deps/
│   │   ├── Arch        # List of native dependencies for Arch
│   │   ├── Ubuntu      # List of native dependencies for Ubuntu
│   │   └── Termux     # List of native dependencies for Termux
│   └── ...             # Other files/scripts as needed
├── package2/
│   └── ...
└── README.md
```

Each package should have an `imake` or a `make` script, or both. These are executable scripts that run the necessary commands to install or update the package.
Make sure your `make` and `imake` scripts are executable (for example `chmod +x make imake`).

The `git` file is optional but useful if the package is based on a Git repository. UUR will clone and update this repo, making it available as `./git_src` inside the `make` and `imake` scripts. The current commit hash will be used as the package version.

If there is no `git` file, the `ver` file should contain the package version.

The `deps` directory contains lists of packages required by the current package. These can be UUR packages or native system packages.

#### Add the repository

To add your repository to UUR:

1. Add your repository’s Git URL to the UUR config file:

```
~/.config/uur/repos
```

Add it on a new line, for example:

```
https://github.com/yourusername/uur-repo-custom.git
```

2. Then update repositories locally by running:

```bash
uur update
```

3. You can now install packages from your repository:

```bash
uur install custom/package1
```
#### Example 
See https://github.com/Federico-Ciuffardi/uur-repo-main

