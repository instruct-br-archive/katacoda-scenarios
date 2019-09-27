
### Boas práticas e performance

Agora temos uma imagem funcional da nossa aplicação, porém se focarmos no tamanho da nossa imagem utilizando o comando `docker images`{{execute}}.

```
REPOSITORY            TAG           IMAGE ID            CREATED             SIZE
minha-aplicacao       latest        7feed57053c8        3 seconds ago       165MB
```
Veremos que nossa aplicação, mesmo sendo um SPA simples está gerando uma imagem de 165MB. Podemos melhorar isso!

### Onde queremos chegar

Se listarmos o que o build da aplicação gera: `docker run --rm -it minha-aplicacao ls -R dist`{{execute}}, veremos que são apenas arquivos JavaScript e HTML.

Com isso podemos usar uma imagem mais leve como por exemplo `docker pull nginx:alpine`{{execute}} que possui apenas 21MB.

Outro ponto importante, se executarmos: `docker run --rm -it minha-aplicacao du -hs node_modules`{{execute}}, veremos que a pasta de dependências da aplicação possui incríveis 120MB, arquivos esses que não são importantes para a aplicação em produção.

### Multi-stage build

Para conseguirmos reduzir o tamanho de nossa aplicação vamos precisar de dois `FROM`: um para construir nossa aplicação e um para entregar apenas os assets (pasta dist) indispensáveis utilizando o nginx.

O primeiro passo será adicionar um NAME ao nosso FROM que já existe para servir de referencia, nesse caso vamos usar o nome `builder` e não utilizaremos mais o server do Node.js.

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM node:8-alpine AS builder
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build
</pre>

Com isso nossa aplicação irá buildar, mas não teremos mais acesso ao seu estado funcional, precisamos adicionar o segundo FROM e dentro do nginx qual pasta nossos arquivos estáticos serão servidos, nesse caso a pasta `/usr/share/nginx/html`:

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM node:8-alpine AS builder
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
</pre>

Agora que definimos a pasta padrão, iremos copiar os arquivos gerados pelo primeiro FROM dentro da pasta dist para dentro da nossa pasta padrão no nginx.

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM node:8-alpine AS builder
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /dist .
</pre>

Por último precisamos deixar claro qual a porta do nginx utiliza, nesse caso a porta 80.

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM node:8-alpine AS builder
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /dist .
EXPOSE 80
</pre>

Se executarmos o comando: `docker run --rm -d -it -p 80:80 --name=app minha-aplicacao`{{execute}}

Você pode fazer um pedido ao seu container: `curl http://docker:80`{{execute}}

Você poderá acessar a página pelo seu navegador (verá o hello world de nossa aplicação). Para isso, acesse a url: visitar a URL https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/

### Resultado

Para conferir o resultado alcançado, execute: `docker images`{{execute}}

Veremos agora que nossa imagem possui apenas 21MB, bem menos dos 165MB iniciais. Não só isso garantimos que o container não receba execuções usando Node.js já que a imagem utilizada para prover a aplicação é a nginx.

