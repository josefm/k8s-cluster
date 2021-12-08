#!/usr/bin/env bash

echo "if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi" | tee -a $HOME/.bashrc | sudo --user=vagrant tee -a $HOME/.bashrc

exit 0