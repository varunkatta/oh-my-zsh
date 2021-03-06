# overrides

# set path
export PATH=$PATH:$HOME/env/bin

# alias over-rides

# (i)nteractive; prompt before overwrite
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias d='dirs -v'   # (v)erbose

# no error if existing, make (p)arent directories as needed
alias mkdir='mkdir -p -v'

#alias d="date +%A\ %m\ %d\ %Y\ %I:%M\ %p\ %Z"

alias df='df -h --sync'         # (h)uman readable format (e.g., 1K 234M 2G), sync first
alias du='du -h --max-depth=0'  # don't recurse into subdirectories
alias g='echo $COLUMNS\x$LINES' # show terminal geometry; also see tput(1)
alias h='history | $PAGER'      # page through history
alias j='jobs'                  # show jobs; shell builtin


# sort service listing by:
alias lsa='ls -lur'         # atime
alias lsd='ls -ltr'         # mtime
alias lst='ls -lcr'         # ctime
alias lsz='ls -lSr'         # size
alias lse='ls -lXB'         # alphabetically
alias lsh='ls -Al'          # all
alias lsg='ls | grep -i'    # grep
alias lsm='ls -al | $PAGER' # page through
alias lsr='ls -lR'          # list recursively


# columnized listing of mounted filesystems
alias mount='mount | column -t 2>/dev/null' 

alias path='echo -e ${PATH//:/\\n}' # print path components, one per line
alias psr='ps -U root -u root u'    # root process listing
alias reboot='su - -c reboot'
alias pstree='pstree -aGp'          # args, vt100 chars, pid
alias mc='mc -b'                    # b/w monochrome
[ -z "${DISPLAY:-}" ] && alias emacs='emacs -nw'
alias mute='amixer sset 'Master' mute >/dev/null'
alias unmute='amixer sset 'Master' unmute >/dev/null'

alias c='clear'
alias cls='clear'
alias l='ls -lart'
alias ll='ls -lart'
alias r='reset'
alias t='tail -100'
alias t2='tail -200'

alias mountmac='sudo mount -t vboxsf machome /home/varun/m'

#start vnm
alias vmstart='VBoxHeadless -s ubuntu-varun'
#stop vm
alias vmstop='VBoxManage  controlvm ubuntu-varun poweroff'
alias vmpause='VBoxManage  controlvm ubuntu-varun pause'
alias vmsave='VBoxManage  controlvm ubuntu-varun save'
alias vmsave='VBoxManage  controlvm ubuntu-varun savestate'
alias vmresume='VBoxManage controlvm ubuntu-varun resume'


alias hgrpl="hg revert -a; hg purge; hgl"
alias mscp="mvn -DskipTests clean package"
alias mcp="mvn clean package"


ostype=$(uname)
if [[ "${ostype}" == "Darwin" ]]
then
  echo "Assuming Mac OS"
  export JAVA_HOME=$(/usr/libexec/java_home)
  export TERM=xterm-256color
else
  echo "Assuming Linux"
  export JAVA_HOME="/usr/java/default"
fi

# screen 
# select the screen of choice.
function sc() {
  set -x
  index=$1
  sh -c "screen -ls | grep -i tty | awk '{print \$1}' | awk '{ if (${index}==NR) {print} }' > /tmp/tmp_screen_id"
  echo Attaching to $(cat /tmp/tmp_screen_id)
  screen -RaAd `cat /tmp/tmp_screen_id`
}
# alias s='screen -RaAd'               # reattach/create, all capabilities, adapt size
alias s='sc'
alias sls='screen -ls | grep -i tty'

# mercurial
alias hgt='hg patch --no-commit'
unalias hgs
alias hgs='hg status $(hg root)'

function hgsa() {
  cd $SRC_WORK_DIR/${COMPANY}
  pwd
  hgs
  popd > /dev/null
  echo
  for i in {1..15}; do
    if [ -e $SRC_WORK_DIR$i ]; then
      cd $SRC_WORK_DIR$i/${COMPANY}
      pwd
      hgs
      echo
      popd > /dev/null
    fi 
  done
}

# yum stuff
alias yli="yum list installed"
alias yi="yum -y install"
alias yr="yum remove"

# tar
funciton dotar() {
  tar -zcvf $1.tgz $1
}
alias untar="tar -zxvf"

# hadoop stuff
alias hfs='hadoop fs'
alias hls='hadoop fs -ls'
alias hdu='hadoop fs -du'
alias hrm='hadoop fs -rm'
alias hrmr='hadoop fs -rmr'
alias hput='hadoop fs -put'
alias hget='hadoop fs -get'

alias hstat='service --status-all | grep -i hadoop'

function hstart() {
  h restart "$@"
}

function hstop() {
  h stop "$@"
}

unalias h
function h() {
  cmd=$1
  name=$2

  if [ $# -eq 0 ]; then
    echo "Usage: h <stop|start|restart> <yarn|classic|rm|nm|jt|tt"
    return
  fi

  
  if [ $# -eq 1 ]; then
    service hadoop-yarn-resourcemanager ${cmd}
    service hadoop-yarn-nodemanager ${cmd}
    return
  fi

  if [[ "${name}" == "yarn" ]]; then
    service hadoop-yarn-resourcemanager ${cmd}
    service hadoop-yarn-nodemanager ${cmd}
    service hadoop-hdfs-namenode ${cmd}
    service hadoop-hdfs-datanode ${cmd}
  elif [[ "${name}" == "classic" ]]; then
    service hadoop-0.20-mapreduce-jobtracker ${cmd}
    service hadoop-0.20-mapreduce-tasktracker ${cmd}
  elif [[ "${name}" == "rm" ]]; then
    service hadoop-yarn-resourcemanager ${cmd}
  elif [[ "${name}" == "nm" ]]; then
    service hadoop-yarn-nodemanager ${cmd}
  elif [[ "${name}" == "jt" ]]; then
    service hadoop-0.20-mapreduce-jobtracker ${cmd}
  elif [[ "${name}" == "tt" ]]; then
    service hadoop-0.20-mapreduce-tasktracker ${cmd}
  fi
}

alias yls='yarn application -list'

function ykill() {
  if [ $# -ne 1 ]; then
    echo "ykill <appid-line-no>. Let line id from yls"
    return
  fi
  yarn application -list | grep -i application_ | awk '{print $1}' | xargs -I{} yarn application -kill {}
}

# colorful man
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
      LESS_TERMCAP_md=$'\E[01;38;5;74m' \
      LESS_TERMCAP_me=$'\E[0m' \
      LESS_TERMCAP_se=$'\E[0m' \
      LESS_TERMCAP_so=$'\E[38;5;246m' \
      LESS_TERMCAP_ue=$'\E[0m' \
      LESS_TERMCAP_us=$'\E[04;38;5;146m' \
      man "$@"
}

# visual notification from a terminal in mac.
function n() {
  if [ $# -eq 0 ]; then
    terminal-notifier -title "Terminal" -message "Finished command"
    return
  fi
  terminal-notifier -title "Terminal" -message "$@"
}

