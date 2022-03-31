TERMUX_PKG_HOMEPAGE=https://github.com/sumithemmadi/ohmyzsh
TERMUX_PKG_NAME="oh-my-zsh"
TERMUX_PKG_DESCRIPTION="A community-driven framework for managing your zsh configuration. Includes 180+ optional plugins and over 120 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community"
TERMUX_PKG_LICENSE="MIT License"
TERMUX_PKG_MAINTAINER="Sumith Emmadi <sumithemmadi244@gmail.com>"
TERMUX_PKG_VERSION=1.0.0
TERMUX_PKG_SRCURL=https://github.com/sumithemmadi/ohmyzsh.git
TERMUX_PKG_GIT_BRANCH=main
TERMUX_PKG_DEPENDS="zsh,git,python"

termux_git_clone_src() {
  cd "${TERMUX_PKG_SRCDIR}/${TERMUX_PKG_NAME}"
  cp "termux.zshrc" "zshrc"
}

termux_step_make_install() {
  cd "${TERMUX_PKG_SRCDIR}/${TERMUX_PKG_NAME}"
  mkdir -p "${TERMUX_PREFIX}/usr/share/oh-my-zsh"
  mkdir -p "${TERMUX_PREFIX}/usr/share/LICENSES/${TERMUX_PKG_NAME}"
  install -D -m644 "zshrc" "${HOME}/.zshrc"
  install -D -m644 "LICENSE.txt" "${TERMUX_PREFIX}/usr/share/LICENSES/${TERMUX_PKG_NAME}/LICENSE"
  cp -rf * "${TERMUX_PREFIX}/usr/share/oh-my-zsh/"
}
