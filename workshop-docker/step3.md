
# Criação não interativa de imagens Docker


Nessa lição, iramos fazer:
  * Escreva o Dockerfile
  * Faça o build
  * Teste

Vamos fazer um teste: Transformar um binário linux em container. Escolhemos, para essa lição, o binário figlet (Ele é um programa que faz "Art ASCII" de uma frase) - nada muito útil, mas bem legal :)



O objetivo é rodar comando como container. Como assim? Iremos isolar o figlet dentro de um container e, sempre que quisermos utilizá-lo, não precisaremos instalar na nossa estação de trabalho, mas sim, apenas executar o referido container.


Eu sei que não faz muito sentido fazer isso com o figlet, mas amplie a idéia, Você poderá isolar QUALQUER serviço ou aplicativo dento de container - Inclusive aplicações de uso pessoal, como navegadores, editores de texto, etc...


Então vamos nessa!




### Primeiro escreva o Dockerfile
Para isso primeiro crie um arquivo vazio com o nome de Dockerfile: `touch Dockerfile`{{execute}}.


Com o o arquivo criado, vá na IDE, abra o arquivo, e escreva o seguinte nele:
  ```shell
FROM ubuntu:18.04
RUN apt-get update \
          && apt-get install --no-install-recommends -y figlet \
          && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/bin/figlet"]
  ```

Para entender melhor sobre CMD e ENTRYPOINT, recomendamos que você leia https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#entrypoint


Um outro link interessante e muito útil é o https://www.fromlatest.io/#/ - Que nos ajuda a conferir algumas melhores práticas para a criação de imagens.


### Construa a imagem
Agora que você inseriu as informações no Dockerfile, chegou a hora de "fazer o build" (a construção) da imagem. Para isso execute: `docker build -t figlet:latest .`{{execute}} - Aguarde a construção do container....


O que isto está acontecendo? Foi enviado o Dockerfile ao docker daemon (serviço local do docker); este, por sua vez, irá fazer a contrução da imagem e, se tudo ocorrer bem, salvar a imagem localmente. A opção "-t figlet:latest" indica o NOME:Versão que você quer dar para a sua imagem. O "." ao final do comando é importante, pois ele indica que o Dockerfile está no diretório local.



Lembre-se que você poderá ver as imagens locais com o comando `docker images`{{execute}}



### Iniciando o container
Agora que já temos a imagem local, vamos testar ela. Vamos chamar o figlet!, para isso, execute o container: `docker run  figlet:latest  Mensagem para o mundo...`{{execute}}






Gostou? Você criou  um container. Novinho em folha. Foi um container simples, mas é seu! :)


### Iniciando um container para usar de forma interativa

Você também pode usar um container de forma interativa. Isto é, iniciar um container e acessar ele para usar, por exemplo, o Bash.


Então, por exemplo, imagina que você precise testar algo em um Ubuntu. Você pode executar um container com o Ubuntu e usá-lo de forma interativa. Para isso, execute: `docker run --rm -it ubuntu:18.04 bash`{{execute}}. Com isso, um Ubuntu foi iniciado e você estará utilizando o Bash o(terminal) do Ubuntu. De certa forma, vocÊ está "detro do container".


Para SAIR do container, você tem que digitar o comando "exit"e prossionar enter. Com isso, você irá retornar para o terminal anterior (o do servidor do tutorial).


Explicando o comando anterior:
  * O "run" solicita ao serviço do docker a inicialização/execução de um container;
  * O "--rm" indica que, ao sair do container (ao finalizá-lo), ele será automaticamente deletado;
  * A opção "-it" indica que iremos usar o container de forma interativa;
  * O "ubuntu:18.04" indica a imagem que queremos usar e a respectiva versão;
  * Por fim, o "bash", indica qual binário (programa) que quero chamar de forma interetiva dentro dessa IMAGEM





O que você viu até agora?
  * É possível criar suas próprias imagens; e
  * É possível usar um container de forma interativa.


Vamos continuar?

Obs.: Para continuar, as atividades acima deverão ter sido executadas.
