#!/bin/bash

mkdir -p "${HOME}/.local/bin" && mkdir -p "${HOME}/.vim/spell"
SYMLINKFILES=( \
	"/.bashrc" \
	"/.gitconfig" \
	"/.gitconfig.user" \
	"/.profile" \
	"/.tmux.conf" \
	"/.vim/vimrc" \
	"/.vim/autoload/rer.vim" \
	"/.fzf/shell/completion.bash" \
	"/.fzf/shell/completion.zsh" \
	"/.bash_prompt"
)
for i in "${SYMLINKFILES[@]}"
do
	test -f "${PWD}${i}" && ln -sf "${PWD}${i}" "${HOME}${i}" || echo "${PWD}${i} not found"
done
