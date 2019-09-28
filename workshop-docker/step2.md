#### Uso básico de docker


O Docker é uma forma muito simples e produtiva de utilizarmos containers.

O Docker permite criar e executar containers independentes usando alguns comandos de linha de comando.

### Executar um container de uma imagem existente

Você pode começar com a tradicional etapa Hello-World, você pode executar um container baseado na imagem hello-world que já existe no Docker Hub.


`docker run --name=hello hello-world`{{execute}}

O que aconteceu??


  * Docker baixou a imagem hello-world, iniciou o container chamado hello-word.
  * O container imprime uma linha de saída hello-world e, em seguida, o docker encerra o container.



#### E por baixo dos panos? O que aconteceu?

  * Quando o mecanismo do Docker recebeu o comando, ele verificou localmente se a imagem do container hello-world existia.
  * Como não existia, acionou internamente uma ação para puxar a imagem.
  * Para referência, você pode disparar manualmente um pedido de download de imagem, por meio do docker pull hello-world.
  * Em seguida, executou a imagem, isso iniciou um novo container e executou o comando definido na imagem.
  * Depois que o comando foi concluído, ele saiu do container.


### Verificando os estados dos containers

O comando `docker ps`{{execute}} lista os containers em execução. Execute o  `docker ps`{{execute}}

Note que você NÃO verá nenhum container porque seu container executou e já não está mais ativo. Para listar containers que já executaram e também os que estão em execução, execute o  `docker ps -a`{{execute}}.


### Listando as imagens

Você também pode verificar quais imagens estão presentes em seu sistema local executando:  `docker images`{{execute}}.


#### De onde é a imagem?

A imagem veio de um Registry (repositório de imagens). No nosso caso, usamos para esse laboratório o registry padrão do docker (DockerHub - https://hub.docker.com/).  

Agora vamos dissecar essa imagem. A imagem do container hello-world está hospedada na página hello-world do DockerHub (https://hub.docker.com/_/hello-world/). Esta imagem possui o seguinte Dockerfile:

    FROM scratch
    COPY hello /
    CMD ["/hello"]


Você pode encontrar a fonte real aqui: (https://github.com/docker-library/hello-world/blob/b715c35271f1d18832480bde75fe17b93db26414/amd64/hello-world/Dockerfile)


Vamos começar nosso entendimento partindo da última linha do Dockerfile:
  * O CMD está especificando que quando esse container é executado.
  * Como o / "hello" chegou lá? Foi copiado usando o comando COPY.
  * O comando FROM especifica que esse container foi construído usando a imagem base "scratch", que é uma imagem especial para construir novas imagens.
  * Nota: A maioria das imagens com as quais você trabalhará NÃO serão construídas a partir do zero, mas criadas a partir de uma camada, como o Ubuntu ou o CoreOS.


Se você questionar de onde o arquivo "hello" foi copiado, ele foi copiado do host onde a imagem estava sendo construída. O arquivo "hello" deve estar na pasta de onde o `docker build` foi chamado no momento em que a imagem foi criada.

Você logo aprenderá a construir suas próprias imagens.


O que acontece quando você executa o container com um comando não padrão que esteja no CMD? Exemplo: `docker run hello-world ls`{{execute}}


Este comando falha porque "ls" não é um comando conhecido dentro deste container.

A imagem hello-world tem um e apenas um arquivo, "hello" e, portanto, não suporta a execução de outros comandos.

Isso é uma EXCELENTE prática, isto é, cada container executar uma, e apenas uma coisa.


Obs.: Para continuar, as atividades acima deverão ter sido executadas.
