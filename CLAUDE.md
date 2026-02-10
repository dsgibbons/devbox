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
