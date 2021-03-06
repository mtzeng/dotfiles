# Options
# --------------------------------------------------------------------

### Check the window size after each command ($LINES, $COLUMNS)
shopt -s checkwinsize

### Disable CTRL-S and CTRL-Q
[[ $- =~ i ]] && stty -ixoff -ixon

### Disable matching hidden files for tab completion
[[ $- =~ i ]] && bind 'set match-hidden-files off'


# Environment variables
# --------------------------------------------------------------------

### Path update utility
# Usage: updpath VARNAME /new/path [append]
updpath() {

  # Two parameters at least
  if [ "$#" -lt 2 ]; then
    return
  fi

  # Expand VARNAME to $orig_dirlist
  # https://unix.stackexchange.com/questions/68035/foo-and-zsh
  eval "orig_dirlist=\"\${$1}\""

  # VARNAME is not set. Assign new path to VARNAME directly
  if [ -z "${orig_dirlist}" ]; then
    eval $1="$2"
    return
  fi

  if [[ "x$3" == "xappend" ]]; then
    is_append=1
  else
    is_append=0
  fi

  if [[ $is_append -eq 1 ]]; then
    new_dirlist=$(echo $2 | tr ':' '\n')
  else
    new_dirlist=
    for dir in $(echo $2 | tr ':' ' '); do
      new_dirlist="$dir $new_dirlist"
    done
  fi

  for dir in $new_dirlist; do
    orig_dirlist=${orig_dirlist/:$dir:/:}
    orig_dirlist=${orig_dirlist/$dir:/}
    orig_dirlist=${orig_dirlist/:$dir/}

    if [[ $is_append -eq 1 ]]; then
      orig_dirlist=$orig_dirlist:$dir
    else
      orig_dirlist=$dir:$orig_dirlist
    fi
  done

  eval $1=$orig_dirlist
}

chbuild () {
  case ${1} in
    "" )
      echo $BUILD_PLATFORM
      ;;
    "-h" )
      echo "chbuild [ 504L0x | 502L0x | 502L0x_cache | 502L0x_old | 470x ]"
      echo "  504L0x - 504L01/L02/devel"
      echo "  502L0x - 502L05/L07/L07p1"
      echo "  502L0x_cache - 502L0x ccache build"
      echo "  502L0x_old - 502L04"
      echo "  470x - 470x platforms"
      ;;
    "504L0x" | "devel")
      updpath LD_LIBRARY_PATH /projects/bca/tools/linux/BCG/crosstools-arm-gcc-9.2-linux-4.19-glibc-2.30-binutils-2.32/usr/lib
      updpath PATH /projects/bca/tools/linux/hndtools-armeabi-2013.11/bin
      TOOLCHAIN_BASE=/projects/bca/tools/linux/BCG; export TOOLCHAIN_BASE
      BUILD_PLATFORM=${1}; export BUILD_PLATFORM
      ;;
    "502L0x" | "502L0x_cache")
      updpath LD_LIBRARY_PATH /projects/bca/tools/linux/BCG/crosstools-arm-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/lib
      updpath PATH /projects/bca/tools/linux/hndtools-armeabi-2013.11/bin
      TOOLCHAIN_BASE=/projects/bca/tools/linux/BCG; export TOOLCHAIN_BASE
      BUILD_PLATFORM=${1}; export BUILD_PLATFORM

      if [ ${BUILD_PLATFORM} == "502L0x_cache" ]; then
        # setup ccache
        CCACHE_DIR=/tmp/${LOGNAME}_ccache; export CCACHE_DIR
        if [ ! -d "$CCACHE_DIR" ]; then
          mkdir $CCACHE_DIR
        fi
        if [ -f /tools/bin/ccache ]; then
          /tools/bin/ccache -M 5G >/dev/null
        fi
      fi
      ;;
    "502L0x_old")
      updpath LD_LIBRARY_PATH /projects/hnd/tools/linux/BCG/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/lib
      updpath PATH /projects/hnd/tools/linux/hndtools-armeabi-2013.11/bin
      TOOLCHAIN_BASE=/projects/hnd/tools/linux/BCG; export TOOLCHAIN_BASE
      BUILD_PLATFORM=${1}; export BUILD_PLATFORM
      ;;
    "470x" | "4708" | "4709")
      updpath LD_LIBRARY_PATH /projects/bca/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/lib
      updpath PATH /projects/bca/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin:/projects/bca/tools/linux/hndtools-armeabi-2011.09/bin
      BUILD_PLATFORM=${1}; export BUILD_PLATFORM
      ;;
    *) ;;
  esac;
}

sendfile() {
  tar -cf - -C `dirname ${1}` `basename ${1}` | pv -s `du -b ${1} | cut -f 1` | nc -vv `echo $SSH_CLIENT | cut -f 1 -d ' '` 8888
}

recvfile() {
  while true; do nc -l 8888 -w1 | tar -xf -; done
}


### PATH Configuration on Linux
OSRel=`uname -r`
STUFF=/projects/bca/tools/linux-$OSRel/bin:/projects/bca/tools/linux/bin
updpath PATH $STUFF append

### setup build path for 490x
chbuild 502L0x

### local bin
updpath PATH $HOME/bin

### nodejs
if [[ -d $HOME/work/tools/nodejs/bin ]]; then
  updpath PATH $HOME/work/tools/nodejs/bin
fi

### clangd - c/c++ language server for vim
if [[ -d /tools/oss/packages/x86_64-rhel6/llvm/11.0.0/bin ]]; then
  updpath PATH /tools/oss/packages/x86_64-rhel6/llvm/11.0.0/bin
fi

### for github TLSv1.2 support
if [[ -d /tools/oss/packages/x86_64-rhel6/firefox/default/lib ]]; then
  updpath LD_LIBRARY_PATH /tools/oss/packages/x86_64-rhel6/firefox/default/lib
fi

SUBVERSIONVER=1.9.2; export SUBVERSIONVER

export P4PORT=ssl:pf-sgn-bca-proxy.devops.broadcom.net:3240
export P4VER=2018.4
export P4USER=mt952679
export P4CLIENT=mt952679
export P4EDITOR=vi

GIT_SSL_NO_VERIFY=true; export GIT_SSL_NO_VERIFY
export HISTCONTROL=ignorespace:erasedups

export SSH_CLIENT_IP=$(echo $SSH_CLIENT | cut -f 1 -d ' ')

# Avoiding a popup window for asking password
# https://superuser.com/questions/758039/git-push-pull-keeps-on-trying-to-produce-gui-window
export SSH_ASKPASS=

# Hide shell deprecated warning on macos after catalina
# https://scriptingosx.com/2019/06/moving-to-zsh/
export BASH_SILENCE_DEPRECATION_WARNING=1

#
export GCCVER=9.1.0
export VIMVER=8.2-p1


# Aliases
# --------------------------------------------------------------------

ls_version="$(ls --version 2>/dev/null)"
if [[ "$ls_version" == *"GNU coreutils"* ]]; then
  alias ls='ls --color=auto'
fi
alias l='ls'
alias l.='ls -d .*'
alias ll.='ls -ld .*'
alias ll='ls -l'
alias lh='ls -lh'
# alias grep
if command -v rg >/dev/null 2>&1; then
  alias grep='rg --ignore-file ~/.ignore --no-heading'
elif command -v ag >/dev/null 2>&1; then
  alias grep='ag --path-to-ignore ~/.ignore --nogroup -s'
else
  alias grep='grep --color --exclude={cscope.*,tags} --exclude-dir={.svn,builds} --binary-files=without-match'
fi
# alias tmux
if command -v tmux >/dev/null 2>&1; then
  alias tmux='tmux -2 -u'
fi
alias vi='vim -X'
alias bd=". bd -si"

# alias perforce
alias p4v="/tools/perforce/$P4VER/bin.linux26x86_64/p4v"

# alias gdb_python
GDB_PATH=$HOME/bin/gdb_python
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/tools/oss/packages/x86_64-rhel6/python/2.7.5/lib
alias gdb_dbg="$GDB_PATH/gdb-python --data-directory=$GDB_PATH/data-directory"


# Functions
# --------------------------------------------------------------------

highlight () { grep --color auto "$1|$" $2 ; }


# Autostart Tmux
# --------------------------------------------------------------------

if command -v tmux >/dev/null 2>&1; then
#  # if not inside a tmux session, and if no session is started, start a new session
  test -z "$TMUX" && (tmux attach || tmux new-session)
fi


# Fuzzy Finder
# --------------------------------------------------------------------

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --type file"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type directory"
fi
export FZF_DEFAULT_OPTS="--reverse"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

