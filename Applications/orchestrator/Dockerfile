FROM node:latest
COPY . .
RUN npm install
ENV TZ=Europe/Brussels
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
CMD [ "node", "index.js"]