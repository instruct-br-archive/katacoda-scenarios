(( $(docker ps -a | grep hello-world 2>/dev/null | wc -l) >= 1 )) && echo \"done\"
