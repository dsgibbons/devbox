# CLAUDE.md

## Project Overview

This is a containerised development environment (devbox) built on Debian bookworm-slim. The Dockerfile defines all pre-installed tools and the `devbox` shell script manages the container lifecycle.

## Important: Keep README.md Up to Date

Whenever you modify the Dockerfile (adding, removing, or changing tools/packages), you **must** update `README.md` to reflect the change. Specifically:

- The **Tools Included** tables must list every tool installed in the Dockerfile
- If a tool is added, add a row to the appropriate table (or create a new section)
- If a tool is removed, remove it from the tables
- If configuration or usage changes, update the relevant README sections

Before finishing any PR or commit that touches the Dockerfile, verify that README.md accurately describes the current state of the devbox.

## Important: Version Bumping

After every change (Dockerfile, devbox script, README, etc.), you **must**:

1. Increment `DEVBOX_VERSION` in **both** `Dockerfile` (`ENV DEVBOX_VERSION=...`) and `devbox` (`DEVBOX_VERSION="..."`) — use minor version bumps (e.g. 0.9 → 0.10)
2. Commit all changes
3. Create a git tag matching the version (e.g. `v0.10`)
4. Push the commit **and** the tag (`git push && git push origin <tag>`)
