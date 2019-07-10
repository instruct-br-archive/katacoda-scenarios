(( $(docker images | grep figlet 2>/dev/null | wc -l) >= 1 )) && echo \"done\"
