#set fish_greeting "Bienvenido @$USER"
set fish_greeting ""
set fish_color_search_match --background black

alias rm "gio trash"
#alias edit "emacs -nw"
alias edit 'emacsclient -t --alternate-editor="emacs -nw"'

function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end

# path
fish_add_path $HOME/.local/bin

function addpaths
    contains -- $argv $fish_user_paths
       or set -U fish_user_paths $fish_user_paths $argv
    echo "Updated PATH: $PATH"
end

function removepath
    if set -l index (contains -i $argv[1] $PATH)
        set --erase --universal fish_user_paths[$index]
        echo "Updated PATH: $PATH"
    else
        echo "$argv[1] not found in PATH: $PATH"
    end
end
