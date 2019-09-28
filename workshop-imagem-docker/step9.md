### Ignorando arquivos

Caso você tenha buildado toda alteração que fez no arquivo Dockerfile perceberá que a geração de imagem não usa cache depois da linha:

```
COPY . ./
```

Isso ocorre pois o Docker checa as mudanças em ".", ou seja, nosso diretório de trabalho e nesse caso Dockerfile possui uma alteração.

Como ele não é um arquivo que precisamos que esteja dentro da nossa imagem, assim como outros arquivos como `*.tmp` ou `.DS_Store` ou pastas como `.git` ou `node_modules`. Podemos ignorar sua existência e garantir que eles não invalidem o cache e não sejam copiados para dentro desse nossa imagem gerando um peso desnecessário.

Para isso criaremos o arquivo `.dockerignore` usando o comando abaixo:

`touch .dockerignore`{{execute}}

No nosso caso, como queremos garantir apenas que o Dockerfile não invalide o cache vamos adicionar:

<pre class="file" data-filename=".dockerignore" data-target="replace">
Dockerfile
</pre>

Agora vamos buildar nossa imagem: `docker build -t minha-aplicacao .`{{execute}}

Com isso novas alterações no arquivo Dockerfile serão ignoradas.

### Usando Argumentos

Em um cenário onde nossa imagem pode ser gerada dinamicamente em uma ferramenta de CI/CD teremos que importar variáveis em tempo de build. Nesse caso utilizaremos a instrução `ARG`


<pre class="file" data-filename="Dockerfile" data-target="replace">
ARG DOCKER_REGISTRY=index.docker.io
FROM $DOCKER_REGISTRY/node:8-alpine AS builder
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /dist .
EXPOSE 80
</pre>

No exemplo acima poderemos receber um argumento em tempo de build da imagem para receber de qual registry baixaremos nossa imagem. No nosso caso deixamos um valor padrão caso esse argumento não seja passado.

Se testarmos executar o comando passando um argumento inválido:

`docker build --build-arg DOCKER_REGISTRY=teste -t minha-aplicacao .`{{execute}}

Veremos que nosso build irá falhar, já que não existe um registry docker "teste", nesse caso precisariamos apontar para um Nexus provisionado dentro de nossa infraestrutura por exemplo.