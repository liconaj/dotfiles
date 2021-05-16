# Defined interactively
function fish_prompt
set_color brred --bold
printf "[%s@%s %s]# " $USER $hostname (prompt_pwd)
set_color normal
end
