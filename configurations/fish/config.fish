#set fish_greeting "Bienvenido @$USER"
set fish_greeting ""
set fish_color_search_match --background black

alias rm "gio trash"
alias edit 'emacsclient -t --alternate-editor="emacs -nw"'


function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end
