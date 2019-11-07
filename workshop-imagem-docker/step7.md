
### Instalando e buildando e executando

Agora que temos nossa imagem base utilizando Node.js precisamos copiar os arquivos do nosso projeto para dentro da imagem, instalar suas dependências e executar o build.

Para isso podemos usar as instruções:

```
FROM node:8-alpine
COPY . ./
RUN npm install
RUN npm run build
```
Na instrução COPY primeiro ponto "." representa o diretório atual e nossos arquivos no host. O segundo "./" representa que queremos copiar todos para o WORKDIR padrão da imagem atual, nesse caso "/" ou raiz.

As demais instruções `npm install` e `npm run build` irão instalar as dependências e buildar nossas aplicação. Porém como vimos na apresentação, cada linha acima irá gerar uma camada que pode ser cacheada reduzindo o tempo de build, porém, como estamos copiando todos os arquivos para dentro da imagem, a cada alteração no código a linha COPY será invalidada e com isso teremos que instalar as dependências em todo o build de imagem.

Para evitar esse cenário e melhorar o uso do cache, vamos utilizar as instruções abaixo:

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM node:8-alpine
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build
</pre>

Com isso garantimos que se nenhuma nova dependência for alterada no arquivo package.json vamos nos aproveitar do cache de sua camada e a seguinte que executa a instalação.

Para testar podemos buildar nossa imagem várias vezes e verificar se todas as camadas utilizam o cache corretamente.

`docker build -t minha-aplicacao .`{{execute}} 


### Executando nossa aplicação

Agora já temos nossa aplicação dentro da imagem, porém ela ainda não está sendo executada, como comentamos o Nuxt possui um comando que sobe um servidor local `npm run dev`. Então vamos atualizar nosso Dockerfile

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM node:8-alpine
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# Servindo nossa aplicação
EXPOSE 3000
CMD ["npm", "run", "dev"]
</pre>

Repare que além da instrução `CMD` no formato exec, acionamos uma nova chamada `EXPOSE` ela não expõe ou abre a porta mas sim é maneira de documentar e deixar explícito em qual porta nossa aplicação estará.

Vamos buildar novamente, sempre verificando se estamos nos aproveitando do cache das camadas anteriores.

`docker build -t minha-aplicacao .`{{execute}} 


### Testando o acesso

Assim como fizemos com o nginx, vamos executar nosso container: `docker run -d --name=app -p 80:3000 minha-aplicacao`{{execute}} . Note "app" é apenas um nome, você pode dar um nome diferente ao seu container, se quiser. O "-p 80:3000" permite expor a porta 3000 do container na porta local 80 do host em que o container é executado.

Agora confirme se o seu container está em execução usando: `docker ps`{{execute}}. Você verá o container nginx na lista.

Você pode fazer um pedido ao seu container: `curl http://docker:80`{{execute}}

Você poderá acessar a página pelo seu navegador (verá o hello world de nossa aplicação). Para isso, acesse a url: visitar a URL https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/

Para PARAR o container: Você pode parar esse container usando o `docker stop app`{{execute}}. Você pode ver os containers parados executando o `docker ps -a`{{execute}}

Depois de parar, você não conseguirá acessar novamente. Para iniciar ele novamente, inicie com: `docker start app`

Você pode excluir permanentemente o container. Para excluir um container, execute: `docker rm app`{{execute}}