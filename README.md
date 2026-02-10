# devbox

A containerised development environment with all my dev tools pre-installed. Works with Docker or Podman, supports both amd64 and arm64 architectures.

## Features

- **One-line installation** - Get started in seconds
- **Pre-built multi-arch images** - Available for amd64 and arm64 on GHCR
- **Persistent sessions** - Container runs in background and survives SSH disconnections
- **Seamless integration** - Mounts your home directory, preserves file permissions, uses host networking
- **Your configs, just work** - `~/.config` is mounted so all your tool configs are available
- **Docker/Podman from inside** - Container socket is mounted for nested container workflows
- **SELinux support** - Works on RHEL-based systems with Podman

## Tools Included

### Editors & Terminal
| Tool | Description |
|------|-------------|
| **helix** | Modal text editor with LSP support |
| **fish** | Friendly interactive shell (default) |
| **zellij** | Terminal multiplexer with session persistence |
| **zoxide** | Smarter cd command that learns your habits |

### Development
| Tool | Description |
|------|-------------|
| **fnm** | Fast Node.js version manager |
| **uv** / **uvx** | Fast Python package manager and runner |
| **rust** / **cargo** | Rust toolchain via rustup |
| **g++** / **clang** | C++ compilers |
| **git** | Version control |
| **gitui** | Terminal UI for git operations |

### Containers & Cloud
| Tool | Description |
|------|-------------|
| **docker** | Container CLI (with compose plugin) |
| **gh** | GitHub CLI for repos, PRs, issues |
| **gh copilot** | AI-powered CLI assistant |

### Utilities
| Tool | Description |
|------|-------------|
| **tree** | Directory structure visualization |
| **htop** | Interactive process viewer |
| **lsof** | List open files and ports |
| **curl** | HTTP client |

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
2. Start a container in the background (survives SSH disconnections)
3. Mount your home directory at the same path
4. Start in your current working directory
5. Run as your user (preserving file permissions)
6. Use host networking (no port mapping needed)
7. Mount Docker/Podman socket for container access

Running `devbox` again will reattach to the existing container.

### Commands

```bash
devbox              # Start or attach to the container
devbox stop         # Stop the running container
devbox pull         # Pull pre-built image from GHCR
devbox build        # Build image locally from Dockerfile
```

### Build Options

```bash
devbox build --platform linux/amd64   # Build for amd64
devbox build --platform linux/arm64   # Build for arm64
```

### Pre-built Images

Pre-built images for amd64 and arm64 are available on GitHub Container Registry:

```bash
docker pull ghcr.io/dsgibbons/devbox:latest
```

## Configuration

Your `~/.config` directory is mounted automatically, so configs for fish, helix, gitui, zellij, and other tools work out of the box.

## Requirements

- Docker or Podman
