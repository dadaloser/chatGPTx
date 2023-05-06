 

# build backend
FROM node:lts-alpine as backend

RUN npm install pnpm -g

WORKDIR /app

COPY ./package.json /app

COPY ./pnpm-lock.yaml /app

RUN pnpm install

COPY . /app

RUN pnpm build

# service
FROM node:lts-alpine as service

RUN npm install pnpm -g

WORKDIR /app

COPY ./package.json /app

COPY ./pnpm-lock.yaml /app

RUN pnpm install --production && rm -rf /root/.npm /root/.pnpm-store /usr/local/share/.cache /tmp/*

COPY . /app

COPY --from=backend /app/build /app/build

EXPOSE 5438

CMD ["pnpm", "run", "prod"]

#服务器单独部署

# 加载镜像
#docker build -t gpt-service .

#创建容器
#docker run -it -p 5438:5438  gpt-service

#后台运行(由于是本机代理,所以直接监听8080的端口)
#docker run --name gpt-service -d -p 5438:5438/tcp gpt-service

#删除容器(-f 强制)
#docker rm -f gpt-service

#删除镜像
#docker rmi -f gpt-service