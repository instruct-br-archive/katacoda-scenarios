
### Nosso projeto JavaScript

Agora que já entendemos o básico do ciclo de vida das imagens e containers, vamos criar uma imagem específica para nosso projeto JavaScript.

Como você deve ter percebido, possuímos alguns arquivos na raiz do nosso diretório:

 - `package.json` Gerencia as dependências via NPM do nosso projeto
 - `nuxt.config.js` e as pastas `layouts` e `pages` São referentes ao nosso projeto JavaScript utilizando Vue/Nuxt.

### Nosso objetivo

Nossa aplicação é uma SPA e queremos entregar ela rodando dentro de um container.
Para isso vamos precisar instalar as dependências do projeto, utilizando o comando `npm install` e buildar nossa aplicação utilizando o comando `npm run build`.
O Nuxt já nos entrega uma servidor local Node.js para disponibilizar nossa aplicação, para isso basta executar o comando `npm run start`

### Utilizando Docker

Caso tenha tentando executar os comandos acima, perceberá que eles não funcionarão já que não possuímos o Node.js instalado.
Justamente para garantir um ambiente de desenvolvimento e de produção idênticos, não vamos instalar o Node.js no nosso host e sim usar uma imagem Docker que será igual para ambos os ambientes.

### Iniciando nossa imagem

Já possuímos o arquivo `Dockerfile` criado nas etapas anteriores, vamos apagar o que existe nele e iniciar um novo.
Nele vamos iniciar utilizando uma imagem do Node.js na versão 8 "alpine". Alpine é uma distribuição Linux leve projetada para segurança e eficiência de recursos.

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM node:8-alpine
</pre>

Se executarmos o comando `docker build -t minha-aplicacao .`{{execute}} 

O Docker irá baixar a imagem node:8-alpine porém ainda não temos nossa aplicação dentro dela, no máximo podemos verificar se possuímos o Node.js instalado corretamente executando: `docker run --rm -it minha-aplicacao node --version`{{execute}}
