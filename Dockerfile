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
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

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

# Set fish as default shell and ensure container binaries take precedence
ENV SHELL=/usr/bin/fish
RUN echo 'set -e fish_user_paths; set -gx PATH /usr/local/bin /usr/bin /bin' >> /etc/fish/config.fish

# Trust all git directories (needed when mounting host directories)
RUN git config --system safe.directory '*'

# Make passwd writable so we can add user at runtime (needed for SSH)
RUN chmod 666 /etc/passwd

CMD ["fish"]
