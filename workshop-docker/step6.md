### Criando um site wordpress

Embora a execução de um único contêiner seja útil, é muito mais útil poder executar vários contêineres em conjunto, de modo que um aplicativo inteiro possa ser executado.


A Docker disponibiliza esse recurso por meio do docker-compose.


O docker-compose nos permite estipular como um conjunto de containers irão se comportar - inclusive como funcionará volumes, rede, portas, etc.

Para essa lição, iremos criar um docker-compose simples para iniciar um Wordpress.


Veja o exemplo de um docker-compose que inicia um Wordpress.


    version: '3.3'
    services:
       db:
         image: mysql:5.7
         restart: always
         environment:
           MYSQL_ROOT_PASSWORD: somewordpress
           MYSQL_DATABASE: wordpress
           MYSQL_USER: wordpress
           MYSQL_PASSWORD: wordpress   

       wordpress:
         depends_on:
           - db
         image: wordpress:latest
         ports:
           - "80:80"
         restart: always
         environment:
           WORDPRESS_DB_HOST: db:3306
           WORDPRESS_DB_USER: wordpress
           WORDPRESS_DB_PASSWORD: wordpress




Crie um arquivo chamado docker-compose.yaml `touch docker-compose.yaml`{{execute}} e inclua o conteúdo acima nele.


Agora, você precisa iniciar a pilha. Para isso, execute: `docker-compose up`{{execute}} .A pilha será iniciada, o banco do wordpress será criado em tempo de execução, após alguns instantes, você verá que o serviço do Apache será iniciando.



Após algum tempo (acompanhe os logs na tela), os containers de banco de dados e o apache serão criados. Quando tudo tiver ativo já, você poderá acessar por aqui para finalizar a instalação do Wordpress: https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ (Recomendamos abrir em uma aba anônima, por causa do cache do browser).


Sim, você acabou de criar um Wordpress novinho!!




Recomendamos:
  * Aprofunde seus estudos nos comandos básicos do docker e docker-compose (use a documentação oficial)
  * Crie pilhas de software para testar o docker-compose
  * Crie novas imagens docker de acordo com suas necessidades de estudo
  * NAVEGUE e CONHEÇA https://hub.docker.com/ . Crie uma conta lá. Aprendas com as imagens docker de outras pessoas e, principalente, publique suas imagens.


Um forte abraço - essas foram lições bem básica, mas fundamentais.
