# devbox

A containerised development environment with all my dev tools pre-installed.

## Tools Included

- **helix** - Modal text editor
- **fish** - Friendly interactive shell
- **gitui** - Terminal UI for git
- **zellij** - Terminal multiplexer
- **zoxide** - Smarter cd command
- **fnm** - Fast Node Manager
- **uv** - Python package manager
- **docker** - Container CLI
- **g++** / **clang** - C++ compilers

## Usage

```bash
./devbox
```

This will:
1. Build the image if it doesn't exist
2. Mount your home directory at the same path
3. Start in your current working directory
4. Run as your user (preserving file permissions)
5. Use host networking (no port mapping needed)

### Options

```bash
./devbox --build                      # Force rebuild
./devbox --build --platform linux/amd64   # Build for amd64
./devbox --build --platform linux/arm64   # Build for arm64
```

## Configuration

Your `~/.config` directory is mounted automatically, so configs for fish, helix, gitui, and zellij work out of the box.

## Requirements

- Docker
