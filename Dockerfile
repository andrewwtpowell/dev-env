FROM alpine:latest

RUN apk add -U --no-cache git \
    zsh tmux bash ncurses ripgrep curl \
    less su-exec tar unzip wget gzip \
    coreutils gettext-tiny-dev

# Build packages
RUN apk add -U --no-cache build-base \
    python3 py-pip go cmake ccache

# Build neovim from source because why not
RUN git clone https://github.com/neovim/neovim
WORKDIR /neovim
RUN git checkout stable
RUN make CMAKE_BUILD_TYPE=Release
RUN make install
    
RUN adduser -Ds /bin/zsh/ me

WORKDIR /home/me
ENV HOME /home/me

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

COPY zshrc .zshrc
COPY nvim .config/nvim
COPY tmux .tmux.conf

COPY entrypoint.sh /bin/entrypoint.sh

WORKDIR /workspace

RUN ["chmod", "+x", "/bin/entrypoint.sh"]
ENTRYPOINT ["/bin/entrypoint.sh"]
