() {
  emulate -L zsh
  (( ! $+__p9k_instant_prompt_disabled )) || return
  typeset -gi __p9k_instant_prompt_disabled=1 __p9k_instant_prompt_sourced=13
  [[ -t 0 && -t 1 && -t 2 && $ZSH_VERSION == 5.7.1 && $ZSH_PATCHLEVEL == zsh-5.7.1-0-g8b89d0d &&
     $TERM_PROGRAM != 'Hyper' && $+VTE_VERSION == 1 &&
     $POWERLEVEL9K_DISABLE_INSTANT_PROMPT != 'true' &&
     $POWERLEVEL9K_INSTANT_PROMPT != 'off' ]] || { __p9k_instant_prompt_sourced=0; return 1; }
  local -i ZLE_RPROMPT_INDENT=1
  local PROMPT_EOL_MARK=%B%S%\#%s%b
  [[ -n $SSH_CLIENT || -n $SSH_TTY || -n $SSH_CONNECTION ]] && local ssh=1 || local ssh=0
  local cr=$'\r' lf=$'\n' esc=$'\e[' rs=$'\x1e' us=$'\x1f'
  local -i height=1
  local prompt_dir=/home/jose/.cache/p10k-jose
  zmodload zsh/langinfo
  if [[ ${langinfo[CODESET]:-} != (utf|UTF)(-|)8 ]]; then
    local lc=es_MX.UTF-8
    local LC_ALL=${lc:-${${(@M)$(locale -a 2>/dev/null):#*.(utf|UTF)(-|)8}[1]:-en_US.UTF-8}}
  fi

  zmodload zsh/terminfo
  (( $+terminfo[cuu] && $+terminfo[cuf] && $+terminfo[ed] && $+terminfo[sc] && $+terminfo[rc] )) || return
  local pwd=${(%):-%/}
  local prompt_file=$prompt_dir/prompt-${#pwd}
  local key=$pwd:$ssh:${(%):-%#}
  local content
  { content="$(<$prompt_file)" } 2>/dev/null || return
  local tail=${content##*$rs$key$us}
  [[ ${#tail} != ${#content} ]] || return
  local P9K_PROMPT=instant
  if (( ! $+P9K_TTY )); then

    typeset -gx P9K_TTY=old
    zmodload -F zsh/stat b:zstat
    zmodload zsh/datetime
    local -a stat
    if zstat -A stat +ctime -- $TTY 2>/dev/null &&
      (( EPOCHREALTIME - stat[1] < 5.0000000000 )); then
      P9K_TTY=new
    fi
  fi
  local -i _p9k__empty_line_i=3 _p9k__ruler_i=3
  local -A _p9k__display_k=(-1/right/background_jobs 27 -1/right/nodenv 37 1/right/nvm 39 1/right/background_jobs 27 1/right/direnv 29 -1/right 13 -1/left/vcs 21 1/right/nordvpn 45 -1/right/ranger 47 1/left/dir 19 1/right/nodenv 37 -1/left 11 -1/right/vi_mode 49 1/right/virtualenv 31 1/right_frame 9 1/right 13 1/right/pyenv 35 1/right/nodeenv 41 -1/right/pyenv 35 1/right/ranger 47 empty_line 1 -1/right/nvm 39 1/right/context 43 -1 5 1/left 11 -1/right/nordvpn 45 -1/right_frame 9 -1/gap 15 1/left/vcs 21 1/right/time 51 -1/right/time 51 -1/right/status 23 1/right/anaconda 33 1 5 1/left_frame 7 -1/left/os_icon 17 ruler 3 -1/left_frame 7 1/gap 15 -1/right/nodeenv 41 1/right/command_execution_time 25 -1/left/dir 19 -1/right/virtualenv 31 1/right/status 23 -1/right/command_execution_time 25 -1/right/direnv 29 -1/right/context 43 1/right/vi_mode 49 1/left/os_icon 17 -1/right/anaconda 33)
  local -a _p9k__display_v=(empty_line hide ruler hide 1 show 1/left_frame show 1/right_frame show 1/left show 1/right show 1/gap show 1/left/os_icon show 1/left/dir show 1/left/vcs show 1/right/status show 1/right/command_execution_time show 1/right/background_jobs show 1/right/direnv show 1/right/virtualenv show 1/right/anaconda show 1/right/pyenv show 1/right/nodenv show 1/right/nvm show 1/right/nodeenv show 1/right/context show 1/right/nordvpn show 1/right/ranger show 1/right/vi_mode show 1/right/time show)
  function p10k() {
    emulate -L zsh
    setopt no_hist_expand extended_glob prompt_percent prompt_subst no_aliases
    [[ $1 == display ]] || return
    shift
    local opt match MATCH prev new pair list name var
    local -i k
    for opt; do
      pair=(${(s:=:)opt})
      list=(${(s:,:)${pair[2]}})
      for k in ${(u@)_p9k__display_k[(I)$pair[1]]:/(#m)*/$_p9k__display_k[$MATCH]}; do
        if (( $#list == 1 )); then
          [[ $_p9k__display_v[k+1] == $list[1] ]] && continue
          new=$list[1]
        else
          new=${list[list[(I)$_p9k__display_v[k+1]]+1]:-$list[1]}
          [[ $_p9k__display_v[k+1] == $new ]] && continue
        fi
        _p9k__display_v[k+1]=$new
        name=$_p9k__display_v[k]
        if [[ $name == (empty_line|ruler) ]]; then
          var=_p9k__${name}_i
          [[ $new == hide ]] && typeset -gi $var=3 || unset $var
        elif [[ $name == (#b)(<->)(*) ]]; then
          var=_p9k__${match[1]}${${${${match[2]//\/}/#left/l}/#right/r}/#gap/g}
          [[ $new == hide ]] && typeset -g $var= || unset $var
        fi
      done
    done
  }

  trap "unset -m _p9k__\*; unfunction p10k" EXIT
  local -a _p9k_t=("${(@ps:$us:)${tail%%$rs*}}")

  if (( LINES == 24 && COLUMNS == 80 )); then
    zmodload -F zsh/stat b:zstat
    zmodload zsh/datetime
    local -a tty_ctime
    if ! zstat -A tty_ctime +ctime -- $TTY 2>/dev/null || (( tty_ctime[1] + 2 > EPOCHREALTIME )); then
      zmodload zsh/datetime
      local -F deadline=$((EPOCHREALTIME+0.025))
      local tty_size
      while true; do
        if (( EPOCHREALTIME > deadline )) || ! tty_size="$(/bin/stty size 2>/dev/null)" || [[ $tty_size != <->" "<-> ]]; then
          (( $+_p9k__ruler_i )) || local -i _p9k__ruler_i=1
          local _p9k__g= _p9k__1r= _p9k__1r_frame=
          break
        fi
        if [[ $tty_size != "24 80" ]]; then
          local lines_columns=(${=tty_size})
          local LINES=$lines_columns[1]
          local COLUMNS=$lines_columns[2]
          break
        fi
      done
    fi
  fi
  typeset -ga __p9k_used_instant_prompt=("${(@e)_p9k_t[-3,-1]}")

  (( height += ${#${__p9k_used_instant_prompt[1]//[^$lf]}} ))
  local _p9k_ret
  function _p9k_prompt_length() {
    local COLUMNS=1024
    local -i x y=$#1 m
    if (( y )); then
      while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
        x=y
        (( y *= 2 ));
      done
      local xy
      while (( y > x + 1 )); do
        m=$(( x + (y - x) / 2 ))
        typeset ${${(%):-$1%$m(l.x.y)}[-1]}=$m
      done
    fi
    _p9k_ret=$x
  }
  local out
  if (( ! $+_p9k__g )); then

  [[ $PROMPT_EOL_MARK == "%B%S%#%s%b" ]] && _p9k_ret=1 || _p9k_prompt_length $PROMPT_EOL_MARK
  local -i fill=$((COLUMNS > _p9k_ret ? COLUMNS - _p9k_ret : 0))
  out+="${(%):-%b%k%f%s%u$PROMPT_EOL_MARK${(pl.$fill.. .)}$cr%b%k%f%s%u%E}"
  fi

  out+="${(pl.$height..$lf.)}$esc${height}A$terminfo[sc]"
  out+=${(%):-"$__p9k_used_instant_prompt[1]$__p9k_used_instant_prompt[2]"}
  if [[ -n $__p9k_used_instant_prompt[3] ]]; then
    _p9k_prompt_length "$__p9k_used_instant_prompt[2]"
    local -i left_len=_p9k_ret
    _p9k_prompt_length "$__p9k_used_instant_prompt[3]"
    local -i gap=$((COLUMNS - left_len - _p9k_ret - ZLE_RPROMPT_INDENT))
    if (( gap >= 40 )); then
      out+="${(pl.$gap.. .)}${(%):-${__p9k_used_instant_prompt[3]}%b%k%f%s%u}$cr$esc${left_len}C"
    fi
  fi
  typeset -g __p9k_instant_prompt_output=${TMPDIR:-/tmp}/p10k-instant-prompt-output-${(%):-%n}-$$
  { echo -n > $__p9k_instant_prompt_output } || return
  print -rn -- "$out" || return
  exec {__p9k_fd_0}<&0 {__p9k_fd_1}>&1 {__p9k_fd_2}>&2 0</dev/null 1>$__p9k_instant_prompt_output
  exec 2>&1
  typeset -gi __p9k_instant_prompt_active=1
  typeset -g __p9k_instant_prompt_dump_file=${XDG_CACHE_HOME:-~/.cache}/p10k-dump-${(%):-%n}.zsh
  if source $__p9k_instant_prompt_dump_file 2>/dev/null && (( $+functions[_p9k_preinit] )); then
    _p9k_preinit
  fi
  function _p9k_instant_prompt_precmd_first() {
    emulate -L zsh
    function _p9k_instant_prompt_sched_last() {
      (( $+__p9k_instant_prompt_active )) || return 0
      () {
        emulate -L zsh
        exec 0<&$__p9k_fd_0 1>&$__p9k_fd_1 2>&$__p9k_fd_2 {__p9k_fd_0}>&- {__p9k_fd_1}>&- {__p9k_fd_2}>&-
        unset __p9k_fd_0 __p9k_fd_1 __p9k_fd_2 __p9k_instant_prompt_active
        typeset -gi __p9k_instant_prompt_erased=1
        print -rn -- $terminfo[rc]${(%):-%b%k%f%s%u}$terminfo[ed]
        if [[ -s $__p9k_instant_prompt_output ]]; then
          cat $__p9k_instant_prompt_output 2>/dev/null
          local _p9k_ret mark="${PROMPT_EOL_MARK-%B%S%#%s%b}"
          _p9k_prompt_length $mark
          local -i fill=$((COLUMNS > _p9k_ret ? COLUMNS - _p9k_ret : 0))
          echo -nE - "${(%):-%b%k%f%s%u$mark${(pl.$fill.. .)}$cr%b%k%f%s%u%E}"
        fi
        zmodload -F zsh/files b:zf_rm
        zf_rm -f -- $__p9k_instant_prompt_output ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh{,.zwc} 2>/dev/null
      }
      setopt no_local_options prompt_cr prompt_sp
    }
    zmodload zsh/sched
    sched +0 _p9k_instant_prompt_sched_last
    precmd_functions=(${(@)precmd_functions:#_p9k_instant_prompt_precmd_first})
  }
  precmd_functions=(_p9k_instant_prompt_precmd_first $precmd_functions)
} && unsetopt prompt_cr prompt_sp || true
