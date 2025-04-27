#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh


# TODO: figure out how to load these aliases in git hooks

alias git-branch-issue="git symbolic-ref HEAD | grep --color=never -Eo '\w{2,5}-[0-9]+' | tr  '[:lower:]'  '[:upper:]'"
alias task-context-project="task context show | grep write | grep -Eo 'project:\w+' | sed 's/^project://'"

function chpwd_profiles() {
    local profile context
    local -i reexecute

    context=":chpwd:profiles:$PWD"
    zstyle -s "$context" profile profile || profile='default'
    zstyle -T "$context" re-execute && reexecute=1 || reexecute=0

    if (( ${+parameters[CHPWD_PROFILE]} == 0 )); then
        typeset -g CHPWD_PROFILE
        local CHPWD_PROFILES_INIT=1
        (( ${+functions[chpwd_profiles_init]} )) && chpwd_profiles_init
    elif [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_leave_profile_$CHPWD_PROFILE]} )) \
            && chpwd_leave_profile_${CHPWD_PROFILE}
    fi  
    if (( reexecute )) || [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_profile_$profile]} )) && chpwd_profile_${profile}
    fi  

    CHPWD_PROFILE="${profile}"
    return 0
}
# Add the chpwd_profiles() function to the list called by chpwd()!
chpwd_functions=( ${chpwd_functions} chpwd_profiles )

# trigger on nav
# TODO: uncomment
# zstyle ":chpwd:profiles:$HOME/src/(*|/*)" profile project

chpwd_profile_project() {
    echo run profile

    [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
    # run when profile changed
    print "chpwd(): Switching to profile: $profile"

    export TASK_BASE_PROJECT=$(task-context-project)
    export DIR_PROJECT=$(basename $PWD)
    export JIRA_ISSUE=$(git-branch-issue)
    projects=($TASK_BASE_PROJECT $JIRA_ISSUE)

    # echo $TASK_BASE_PROJECT

    # TODO: should only be set if not already set?
    export PROJECT="${TASK_BASE_PROJECT}."
    sep=.
    echo projects $projects
    echo projects ${(pj..)projects}

    print "env"
    echo DIR_PROJECT=$PROJECT
    echo JIRA_ISSUE=$JIRA_ISSUE
    echo jira issue: $JIRA_ISSUE
    echo task base: $TASK_BASE_PROJECT
}

echo loaded
# trigger on load
# TODO: uncomment
# chpwd_profiles


# also triggred as global git checkout hook
