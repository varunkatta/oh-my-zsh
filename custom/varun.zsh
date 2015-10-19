# overrides

# set path
export PATH=$PATH:$HOME/env/bin

# aliase over-rides

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
if [ "${ostype}" == "darwin" ]; then
  echo "Assuming Mac OS"
  export JAVA_HOME=$(/usr/libexec/java_home)
else
  echo "Assuming Linux"
  export JAVA_HOME=/usr/java/default


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

function hgsa() {
  cd $HOME/src/pepperdata
  pwd
  hgs
  echo
  for i in {1..5}; do
    cd $HOME/src$i/pepperdata
    pwd
    hgs
    echo
  done  
}
