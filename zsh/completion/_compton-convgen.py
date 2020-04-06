#compdef compton-convgen.py

# zsh completions for 'compton-convgen.py'
# automatically generated with http://github.com/RobSis/zsh-completion-generator
local arguments

arguments=(
  {-h,--help}'[show this help message and exit]'
  '-f[\[FACTOR ...\], --factor FACTOR \[FACTOR ...\]]'
  '--dump-compton[dump in compton format.]'
  '*:filename:_files'
)

_arguments -s $arguments
