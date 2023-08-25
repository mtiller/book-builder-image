# FROM --platform=linux/amd64 openmodelica/openmodelica:v1.20.0-minimal
FROM openmodelica/openmodelica:v1.20.0-minimal

# This is currently preventing apt-get updates from working
RUN rm /etc/apt/sources.list.d/openmodelica.list

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y sudo python3 git python3-pip  latexmk texlive-xetex texlive-fonts-extra-links xindy texlive-latex-extra nodejs golang-go language-pack-en && \
 	rm -rf /var/lib/apt/lists/*

# These are tools used by the Go language extension for VS Code
RUN go install -v github.com/mdempsky/gocode@v0.0.0-20200405233807-4acdcbdea79d
RUN go install -v github.com/ramya-rao-a/go-outline@v0.0.0-20210608161538-9736a4bde949
RUN go install -v golang.org/x/tools/gopls@latest
RUN go install -v github.com/go-delve/delve/cmd/dlv@latest

RUN pip install jinja2 matplotlib scipy sphinx dvc[all]