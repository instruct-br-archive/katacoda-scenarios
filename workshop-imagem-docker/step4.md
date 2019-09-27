### Praticando

Nós também podemos rodar imagens mais interessantes do que hello-world, que são múltiplos arquivos. E também podemos rodar comandos de dentro de um container, sem entrar nele.

Vamos pegar como o exemplo a imagem do busybox (poderia ser Ubuntu, CentOS, etc...). Vamos usar o busybox, pois ele é uma ótima imagem para aprender Docker, pois contém os binários dos comandos mais comuns do Linux, como ls, echo, etc.

Vamos primeiro puxar a imagem do busybox, para isso, execute: `docker pull busybox`{{execute}}

Agora iremos testar a execução de comandos pelo container. Isto é, iremos executar comandos linux não no nosso servidor que está fazendo este laboratório, mas sim dentro do container que está sendo executado.

Note também que, para cada comando, é criado e executado um container (e isso é bem rápido..). Então vamos testar algumas coisas:


  * Executando um "pwd" no container busybox: `docker run busybox pwd`{{execute}}. Este comando lhe dirá que o diretŕoio do container que você está usando é o / , que é o diretório de trabalho padrão. Este é outro parâmetro que podemos definir usando o Dockerfile no momento da construção da imagem.

  * Vamos ver o conteúdo deste diretório de trabalho: `docker run busybox ls`{{execute}} . Você pode executar "ls" em outra pasta da imagem, por exemplo, `docker run busybox ls /bin`{{execute}}

  *  Agora, tente isto: `docker run busybox whoami`{{execute}} . Sim, neste container especificamente, você é o root e todos os comandos  são executados como root por padrão. Isto merece um ponto de atenção, não é mesmo?


OK! Nesta lição você viu:
  * Como fazer o download de uma imagem, utilizando o ` docker pull <nome_imagem> `
  * Fez alguns testes com comandos sendo executados diretamente dentro de containers docker.
