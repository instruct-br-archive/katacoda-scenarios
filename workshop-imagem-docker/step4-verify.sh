(( $(docker images | grep busybox 2>/dev/null | wc -l) >= 1 )) && echo \"done\"
