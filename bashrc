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
updpath() {
  if [ -z "${!1}" ]; then
    eval $1="$2"
    return
  fi

  orig_dirlist=${!1}

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
      echo "${0} [ 490x | 490x_orig | 490x_old | 470x ]"
      echo "  490x - 490x ccache build"
      echo "  490x_orig - 490x wo ccache"
      echo "  490x_old - 490x 502L04"
      echo "  470x - 470x platforms"
      ;;
    "4708" | "4709" | "470x")
      updpath PATH /projects/bca/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin:/projects/bca/tools/linux/hndtools-armeabi-2011.09/bin
      BUILD_PLATFORM=470x; export BUILD_PLATFORM
      ;;
    "4906_orig" | "4908_orig" | "490x_orig")
      updpath LD_LIBRARY_PATH /projects/bca/tools/linux/BCG/crosstools-aarch64-gcc-5.3-linux-4.1-glibc-2.24-binutils-2.25/usr/lib/:/usr/lib
      updpath PATH /projects/bca/tools/linux/hndtools-armeabi-2013.11/bin
      TOOLCHAIN_BASE=/projects/bca/tools/linux/BCG; export TOOLCHAIN_BASE
      BUILD_PLATFORM=490x_orig; export BUILD_PLATFORM
      ;;
    "4906" | "4908" | "490x")
      updpath LD_LIBRARY_PATH /projects/bca/tools/linux/BCG/crosstools-arm-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/lib
      updpath PATH /projects/bca/tools/linux/hndtools-armeabi-2013.11/bin
      TOOLCHAIN_BASE=/projects/bca/tools/linux/BCG/cached; export TOOLCHAIN_BASE

      # setup ccache
      CCACHE_DIR=/tmp/${LOGNAME}_ccache; export CCACHE_DIR
      if [ ! -d "$CCACHE_DIR" ]; then
        mkdir $CCACHE_DIR
      fi

      if [ -f /tools/bin/ccache ]; then
        /tools/bin/ccache -M 5G >/dev/null
      fi

      BUILD_PLATFORM=490x; export BUILD_PLATFORM
      ;;
    "4906_old" | "4908_old" | "490x_old")
      updpath LD_LIBRARY_PATH /projects/hnd/tools/linux/BCG/crosstools-arm-gcc-5.3-linux-4.1-glibc-2.22-binutils-2.25/usr/lib
      updpath PATH /projects/hnd/tools/linux/hndtools-armeabi-2013.11/bin
      TOOLCHAIN_BASE=/projects/hnd/tools/linux/BCG; export TOOLCHAIN_BASE
      BUILD_PLATFORM=490x_old; export BUILD_PLATFORM
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
chbuild 490x

### local bin
updpath PATH $HOME/bin

### for github TLSv1.2 support
if [[ -d /tools/oss/packages/x86_64-rhel6/firefox/default/lib ]]; then
  updpath LD_LIBRARY_PATH /tools/oss/packages/x86_64-rhel6/firefox/default/lib
fi

### for svn
if [[ -r /tools/lsf/lsfsite ]]; then
  SITE=`cat /tools/lsf/lsfsite`
  if [[ $SITE == "sina" ]]; then
    # Site 'sina' is not defined in hnd tool
    SITE=hc
  fi
  export SITE
fi
SUBVERSIONVER=1.8.14; export SUBVERSIONVER
SVNROOT=http://bcawlan-svn.${SITE}.broadcom.net/svn/bcawlan/proj
#SVNB=$SVNROOT/branches
#SVNP=$SVNROOT/project_configs
#SVNR=$SVNROOT/tags
#SVNT=$SVNROOT/trunk

export P4PORT=pf-irva-bca.broadcom.com:3240
export P4VER=2012.2
export P4USER=mt952679
export P4CLIENT=mt952679
export P4EDITOR=vi

GIT_SSL_NO_VERIFY=true; export GIT_SSL_NO_VERIFY
export HISTCONTROL=ignorespace:erasedups

export SSH_CLIENT_IP=$(echo $SSH_CLIENT | cut -f 1 -d ' ')

# Avoiding a popup window for asking password
# https://superuser.com/questions/758039/git-push-pull-keeps-on-trying-to-produce-gui-window
export SSH_ASKPASS=


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
if command -v rg >/dev/null 2>&1; then
  alias grep='rg --ignore-file ~/.ignore --no-heading'
elif command -v ag >/dev/null 2>&1; then
  alias grep='ag --path-to-ignore ~/.ignore --nogroup -s'
else
  alias grep='grep --color --exclude={cscope.*,tags} --exclude-dir={.svn,builds} --binary-files=without-match'
fi
alias tmux='tmux -2 -u'
alias vi='vim -X'
alias bd=". bd -si"


# Functions
# --------------------------------------------------------------------

highlight () { grep --color "$1|$" $2 ; }


# Autostart Tmux
# --------------------------------------------------------------------

if command -v tmux >/dev/null 2>&1; then
#  # if not inside a tmux session, and if no session is started, start a new session
  test -z "$TMUX" && (tmux attach || tmux new-session)
fi


# Fuzzy Finder
# --------------------------------------------------------------------

export FZF_DEFAULT_OPTS='--reverse'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

