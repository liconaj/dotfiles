# Defined interactively
function fish_prompt
set_color brgreen --bold
printf "[%s@%s %s]\$ " $USER $hostname (prompt_pwd)
set_color normal
end
