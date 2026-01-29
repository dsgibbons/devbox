FROM debian:bookworm-slim

# Install runtime dependencies and C++ compiler
RUN apt-get update && apt-get install -y \
    g++ \
    clang \
    git \
    curl \
    ca-certificates \
    xz-utils \
    gnupg \
    unzip \
    ncurses-term \
    fish \
    tree \
    lsof \
    htop \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub Copilot CLI extension manually (avoids auth requirement)
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then COPILOT_ARCH="linux-arm64"; else COPILOT_ARCH="linux-amd64"; fi && \
    mkdir -p /usr/share/gh-extensions/github/gh-copilot && \
    curl -L "https://github.com/github/gh-copilot/releases/latest/download/${COPILOT_ARCH}" -o /usr/share/gh-extensions/github/gh-copilot/gh-copilot && \
    chmod +x /usr/share/gh-extensions/github/gh-copilot/gh-copilot
ENV GH_EXTENSIONS_DIR=/usr/share/gh-extensions

# Install helix from prebuilt binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then HELIX_ARCH="aarch64"; else HELIX_ARCH="x86_64"; fi && \
    curl -L "https://github.com/helix-editor/helix/releases/download/25.07.1/helix-25.07.1-${HELIX_ARCH}-linux.tar.xz" | tar -xJ -C /opt && \
    ln -s /opt/helix-25.07.1-${HELIX_ARCH}-linux/hx /usr/local/bin/hx && \
    ln -s /opt/helix-25.07.1-${HELIX_ARCH}-linux/runtime /usr/share/helix-runtime
ENV HELIX_RUNTIME=/usr/share/helix-runtime

# Install gitui from prebuilt binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then GITUI_ARCH="aarch64"; else GITUI_ARCH="x86_64"; fi && \
    curl -L "https://github.com/extrawurst/gitui/releases/latest/download/gitui-linux-${GITUI_ARCH}.tar.gz" | tar -xz -C /usr/local/bin

# Install zellij from prebuilt binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then ZELLIJ_ARCH="aarch64-unknown-linux-musl"; else ZELLIJ_ARCH="x86_64-unknown-linux-musl"; fi && \
    curl -L "https://github.com/zellij-org/zellij/releases/latest/download/zellij-${ZELLIJ_ARCH}.tar.gz" | tar -xz -C /usr/local/bin

# Install zoxide from prebuilt binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then ZOXIDE_ARCH="aarch64"; else ZOXIDE_ARCH="x86_64"; fi && \
    curl -L "https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.8/zoxide-0.9.8-${ZOXIDE_ARCH}-unknown-linux-musl.tar.gz" | tar -xz -C /tmp && \
    mv /tmp/zoxide /usr/local/bin/

# Install fnm from prebuilt binary
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then FNM_FILE="fnm-arm64.zip"; else FNM_FILE="fnm-linux.zip"; fi && \
    curl -L "https://github.com/Schniz/fnm/releases/latest/download/${FNM_FILE}" -o /tmp/fnm.zip && \
    unzip -d /usr/local/bin /tmp/fnm.zip && \
    chmod +x /usr/local/bin/fnm && \
    rm /tmp/fnm.zip

# Install uv system-wide
RUN curl -LsSf https://astral.sh/uv/install.sh | env INSTALLER_NO_MODIFY_PATH=1 sh -s -- --no-modify-path \
    && mv /root/.local/bin/uv /usr/local/bin/ \
    && mv /root/.local/bin/uvx /usr/local/bin/

# Let uv install Python to a writable shared location
RUN mkdir -p /opt/python && chmod 777 /opt/python
ENV UV_PYTHON_INSTALL_DIR=/opt/python

# Set fish as default shell and ensure container binaries take precedence
ENV SHELL=/usr/bin/fish
RUN echo 'set -e fish_user_paths; set -gx PATH /usr/local/bin /usr/bin /bin' >> /etc/fish/config.fish

# Trust all git directories (needed when mounting host directories)
RUN git config --system safe.directory '*'

# Make passwd writable so we can add user at runtime (needed for SSH)
RUN chmod 666 /etc/passwd

CMD ["fish"]
