# build front-end
FROM node:lts-alpine AS frontend

RUN npm install pnpm -g

WORKDIR /app

COPY ./package.json /app

COPY ./pnpm-lock.yaml /app

RUN pnpm install

COPY . /app

RUN pnpm run build

# build backend
FROM node:lts-alpine as backend

RUN npm install pnpm -g

WORKDIR /app

COPY /service/package.json /app

COPY /service/pnpm-lock.yaml /app

RUN pnpm install

COPY /service /app

RUN pnpm build

# service
FROM node:lts-alpine as service

RUN npm install pnpm -g

WORKDIR /app

COPY /service/package.json /app

COPY /service/pnpm-lock.yaml /app

RUN pnpm install --production && rm -rf /root/.npm /root/.pnpm-store /usr/local/share/.cache /tmp/*

COPY /service /app

COPY --from=frontend /app/dist /app/public

COPY --from=backend /app/build /app/build

EXPOSE 5438

CMD ["pnpm", "run", "prod"]


#前后端部署在同一台服务器

# 加载镜像
#docker build -t openai-api-proxy .

#创建容器
#docker run -p 5440:8080 openai-api-proxy 

#后台运行(由于是本机代理,所以直接监听8080的端口)
#docker run --name openai-api-proxy -d -p 5440:8080 openai-api-proxy

#删除容器(-f 强制)
#docker rm -f openai-api-proxy 

#删除镜像
#docker rmi -f openai-api-proxy 