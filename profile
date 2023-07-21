TERM=xterm-256color; export TERM
CLICOLOR=1; export CLICOLOR


#######################################
#PERSONAL CUSTOMIZATION BELOW THIS LINE
#######################################
VISUAL=vim          ; export VISUAL
EDITOR="$VISUAL"    ; export EDITOR

LANG=en_US.UTF-8    ; export LANG
LC_CTYPE=en_US.UTF-8; export LC_CTYPE
LC_ALL=en_US.UTF-8  ; export LC_ALL
TZ=Asia/Taipei      ; export TZ

if [ "$BASH" ]; then
  if [ "$PS1" ]; then
    PS1='\u@\h:\W$ '
  fi

  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
else
  if [ "`id -u`" -eq 0 ]; then
    PS1='# '
  else
    PS1='$ '
  fi
fi
