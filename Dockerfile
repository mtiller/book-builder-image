# FROM --platform=linux/amd64 openmodelica/openmodelica:v1.20.0-minimal
FROM openmodelica/openmodelica:v1.20.0-minimal

# This is currently preventing apt-get updates from working
RUN rm /etc/apt/sources.list.d/openmodelica.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl gnupg ca-certificates vim sudo python3 git python3-pip librsvg2-bin latexmk texlive-xetex texlive-fonts-extra-links xindy texlive-latex-extra golang-go language-pack-en \
    && curl -L https://deb.nodesource.com/setup_18.x | bash \
    && curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | tee /etc/apt/sources.list.d/1password.list \
    && mkdir -p /etc/debsig/policies/AC2D62742012EA22/ \
    && curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | tee /etc/debsig/policies/AC2D62742012EA22/1password.pol \
    && mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 \
    && curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg \
    && apt-get update -yq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq nodejs 1password-cli \
    && rm -rf /var/lib/apt/lists/*

# These are tools used by the Go language extension for VS Code (install them in /usr/local/bin, not in roots home directory)
RUN GOBIN=/usr/local/bin go install github.com/mdempsky/gocode@v0.0.0-20200405233807-4acdcbdea79d
RUN GOBIN=/usr/local/bin go install github.com/ramya-rao-a/go-outline@v0.0.0-20210608161538-9736a4bde949
RUN GOBIN=/usr/local/bin go install golang.org/x/tools/gopls@latest
RUN GOBIN=/usr/local/bin go install github.com/go-delve/delve/cmd/dlv@latest
RUN GOBIN=/usr/local/bin go install github.com/joho/godotenv/cmd/godotenv@latest

RUN pip install jinja2 matplotlib scipy sphinx dvc[all] python-gettext

RUN npm install --global yarn

# Create a user for VS Code dev containers (but we don't switch to it here)
RUN useradd -m  -s /bin/bash ubuntu
# RUn mkdir /etc/sudoers.d
RUN usermod -aG sudo ubuntu && echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu
RUN chmod 0440 /etc/sudoers.d/ubuntu
