(( $(grep "Trata-se um exemplo de texto" teste-terminal.txt 2>/dev/null | wc -l) >= 1)) && echo \"done\"
