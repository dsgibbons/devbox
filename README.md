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

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/dsgibbons/devbox/main/install.sh | sh
```

This installs `devbox` to `~/.local/bin`. Make sure it's in your PATH.

## Usage

```bash
devbox
```

This will:
1. Pull the image from GHCR (or build locally if Dockerfile present)
2. Mount your home directory at the same path
3. Start in your current working directory
4. Run as your user (preserving file permissions)
5. Use host networking (no port mapping needed)

### Options

```bash
./devbox --pull                           # Pull pre-built image from GHCR
./devbox --build                          # Force local rebuild
./devbox --build --platform linux/amd64   # Build for amd64
./devbox --build --platform linux/arm64   # Build for arm64
```

### Pre-built Images

Pre-built images for amd64 and arm64 are available on GitHub Container Registry:

```bash
docker pull ghcr.io/dsgibbons/devbox:latest
```

## Configuration

Your `~/.config` directory is mounted automatically, so configs for fish, helix, gitui, and zellij work out of the box.

## Requirements

- Docker
