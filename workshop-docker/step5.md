### Um servidor web


Primeiro, vamos citar alguns conceitos importantes:

  * O tempo de vida de um container é igual ao tempo de vida do processo mestre. Se o processo mestre for um serviço, como nginx, o container será executado por um período mais longo.
  * Podemos usar o docker executando da forma "Detached mode", isto é: O container irá executar em segundo plano (background) e sem dependência do terminal - isto é, ao sair do terminal, o container não irá finalizar. Exemplo: `docker run -d <nome_imagem>`
  * Podemos redirecionar/ligar uma porta do host a uma porta do container. Chamamos isso de expor portas. Para isso, indicamos o redirecionamento de portas assim: "-p <container port>: <host port>". A execução seria algo nesse sentido: `docker run -p 80:8080 <nome_imagem>`. Nesse exemplo, estariamos apontando a porta 8080 do container para a porta 80 do host. Com isso, você iria conseguir "acessar o serviço do container" chamando a porta 80 no host.



Bom, agora que fizemos as honras e apresentamos alguns conceitos interessantes, vamos estudar um pouquinho. Para esta etapa, vamos utilizar um container de Nginx. Vamos nessa!


  * Primeiro puxe a imagem do container nginx para o host. Para isso, execute: `docker pull nginx`{{execute}}
  * Execute o container nginx da seguinte maneira: `docker run --name=mynginx nginx`{{execute}}
  * Você verá que a tela trava e você não obtém nenhuma saída. Agora mate o container pressionando Control-C.


### Inicie, pare, chame e delete um container

Agora, execute novamente o mesmo container no modo deamon usando "-d" da seguinte forma: `docker run -d --name=meusite -p 80:80 nginx`{{execute}} . Note "meusite" é apenas um nome, você pode dar um nome diferente ao seu container, se quiser. O "-p 80:80" permite expor a porta 80 do container na porta local 80 do host em que o container é executado.



Agora confirme se o seu container está em execução usando: `docker ps`{{execute}}. Você verá o container nginx na lista.


Você pode fazer um pedido ao seu container: `curl http://localhost:80`{{execute}}


Você poderá acessar a página pelo seu navegador (verá a tela default do nginx). Para isso, acesse a url: visitar a URL https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/



Para PARAR o container: Você pode parar esse container usando o `docker stop meusite`{{execute}}. Você pode ver os containers parados executando o `docker ps -a`{{execute}}


Depois de parar, você não conseguirá acessar novamente. Para iniciar ele novametne, inicie com: `docker start meusite`


Você pode excluir permanentemente o container. Para excluir um container, execute: `docker rm meusite`{{execute}}



Nesta lição você viu:
  * Que podemos iniciar containers como serviços com a opção "-d"
  * Podemos expor portas do container para o host, por da opção "-p"
  * Podemos PARAR, INICIAR e EXCLUIR containers.


Vamos continuar?
