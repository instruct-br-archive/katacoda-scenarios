#### Uso básico de docker


Como vimos durante o Workshop, o docker é uma forma muito simples e produtiva de usar-se containers.

O Docker permite criar e executar contêineres independentes usando alguns comandos de linha de comando.

### Executar um contêiner de uma imagem existente

Você pode começar com a tradicional etapa Hello-World, você pode executar um contêiner baseado na imagem hello-world que já existe no Docker Hub.


`docker run --name=hello hello-world`{{execute}}

O que aconteceu??


  * Docker baixou a imagem hello-world, iniciou o container chamado hello-word.
  * O contêiner imprime uma linha de saída hello-world e, em seguida, o docker encerra o contêiner.



#### E por baixo dos panos? O que aconteceu?

  * Quando o mecanismo do Docker recebeu o comando, ele verificou localmente se a imagem do contêiner hello-world existia.
  * Como não existia, acionou internamente uma ação para puxar a imagem.
  * Para referência, você pode disparar manualmente um pedido de download de imagem, por meio do docker pull hello-world.
  * Em seguida, executou a imagem, isso iniciou um novo contêiner e executou o comando definido na imagem.
  * Depois que o comando foi concluído, ele saiu do contêiner.


### Verificando os estados dos containers

O comando `docker ps`{{execute}} lista os containers em execução. Execute o  `docker ps`{{execute}}

Note que você NÃO verá nenhum contêiner porque seu contêiner executou e já não está mais ativo. Para listar contêineres que já executaram e tambén os que estão em execução, execute o  `docker ps -a`{{execute}}.


### Listando as imagens

Você também pode verificar quais imagens estão presentes em seu sistema local executando:  `docker images`{{execute}}.


#### De onde é a imagem?

A imagem veio de um Registry (repositório de imagens). No nosso caso, usamos para esse labortaório o registry padrão do docker (DockerHub - https://hub.docker.com/).  

Agora vamos dissecar essa imagem. A imagem do container hello-world está hospedada na página hello-world do DockerHub (https://hub.docker.com/_/hello-world/). Esta imagem possui o seguinte Dockerfile:

    FROM scratch
    COPY hello /
    CMD ["/hello"]


Você pode encontrar a fonte real aqui: (https://github.com/docker-library/hello-world/blob/b715c35271f1d18832480bde75fe17b93db26414/amd64/hello-world/Dockerfile)


Vamos começar nosso entendimento partindo da última linha do Dockerfile:
  * O CMD está especificando que quando esse contêiner é executado.
  * Como o / "hello" chegou lá? Foi copiado usando o comando COPY.
  * O comando FROM especifica que esse contêiner foi construído usando a imagem base "scratch", que é uma imagem especial para construir novas imagens.
  * Nota: A maioria das imagens com as quais você trabalhará NÃO serão construídas a partir do zero, mas criadas a partir de uma camada, como o Ubuntu ou o Coreos.


Se você questionar de onde o arquivo "hello" foi copiado, ele foi copiado do host onde a imagem estava sendo construída. O arquivo "hello" deve estar na pasta de onde o `docker build` foi chamado no momento em que a imagem foi criada.

Você logo aprenderá a construir suas próprias imagens.


O que acontece quando você executa o contêiner com um comando não padrão que esteja no CMD? Exemplo: `docker run hello-world ls`{{execute}}


Este comando falha porque "ls" não é um comando conhecido dentro deste contêiner.

A imagem hello-world tem um e apenas um arquivo, "hello" e, portanto, não suporta a execução de outros comandos.

Isso é uma EXCELENTE prática, isto é, cada container executar uma, e apenas uma coisa.


Obs.: Para continuar, as atividades acima deverão ter sido executadas.
