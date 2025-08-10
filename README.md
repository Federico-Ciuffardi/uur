# Universal User Repository (UUR)

**UUR** (Universal User Repository) is a lightweight package manager designed to install and manage software from multiple sources, with fallback to native package managers.

## Features

- Install packages from UUR repositories
- Fallback to native package managers (Pacman/Yay for Arch, APT for Ubuntu/Termux)
- Package upgrades
- Repository updates
- Cross-distro support: **Arch**, **Ubuntu**, **Termux**
- Minimal dependencies

## Installation
Run `sudo make install`, this will:
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
```
# Update repos
uur update

# Install the bootstrap package
uur install main/bootstrap

# List installed packages
uur list -i
```

## UUR Repositories

By default, UUR adds the main repo:

```
https://github.com/Federico-Ciuffardi/uur-repo-main
```

### How to create and add a new UUR repository

#### Create the repository 
Make a new Git repo (on GitHub, GitLab, or your preferred Git hosting). This repo will hold your package directories and metadata.
 
You should name the repo `uur-repo-<repo name>`, note that the `<repo name>` cannot contain `-`.

The repo and its packages should look like this:
```
repo-name/
├── package1/
│   ├── imake           # Build script (allows user interaction)
│   ├── make            # Build script (does not allow user interaction)
│   ├── git             # URL of the upstream Git source
│   ├── ver             # Version identifier
│   ├── deps/
│   │   ├── Arch        # List of native deps for Arch
│   │   ├── Ubuntu      # List of native deps for Ubuntu
│   │   └── Termux     # List of native deps for Termux
│   └── ...             # Other files/scripts as needed
├── package2/
│   └── ...
└── README.md
```

All the packages should have and `imake` or a `make` or both. These are script or executables that will run the necesary commandst to install or update the package. Make sure `make` and `imake` scripts are executable (`chmod +x make`).

The `git` file is optional but helps if the package is based on a git repo, it will clone and update that git repo (will be available as `./git_src` from the `make` and `imake`), and its current commit will be used to version the package.

In case there isn't a `git` file, the `ver` file will cointain the version of the package.

The `deps` are lists of the packages that the current package need to work, it can be UUR packages or native packages.


#### Add the repository

* Add your repo git URL to the UUR config file:
```
~/.config/uur/repos
```
On a new line, like:
```
https://github.com/yourusername/uur-repo-custom.git
```

* Then run:
```bash
uur update
```
to clone and update the repository locally.

* Now you can install you packages with
```bash
uur install custom/package1
```
