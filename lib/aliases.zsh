# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# Super user
alias _='sudo'
alias please='sudo'

#alias g='grep -in'

# Show history
if [ "$HIST_STAMPS" = "mm/dd/yyyy" ]
then
    alias history='fc -fl 1'
elif [ "$HIST_STAMPS" = "dd.mm.yyyy" ]
then
    alias history='fc -El 1'
elif [ "$HIST_STAMPS" = "yyyy-mm-dd" ]
then
    alias history='fc -il 1'
else
    alias history='fc -l 1'
fi
# List direcory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias sl=ls # often screw this up

alias afind='ack-grep -il'

alias x=extract

#more aliases

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
alias s='screen -RaA'               # reattach/create, all capabilities, adapt size
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

alias vmstop='VBoxManage  controlvm ubuntu-varun poweroff'
alias vmpause='VBoxManage  controlvm ubuntu-varun pause'
alias vmsave='VBoxManage  controlvm ubuntu-varun save'
alias vmsave='VBoxManage  controlvm ubuntu-varun savestate'
alias vmresume='VBoxManage controlvm ubuntu-varun resume'
#stop vm
