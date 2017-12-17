FROM node:latest

RUN mkdir /app
WORKDIR /app

COPY package.json /app
RUN npm install

RUN docker-compose exec mongo mongo
CMD mongo
CMD use admin  

CMD db.createUser({user: "root", pwd: "root", roles:[{role: "userAdminAnyDatabase", db: "admin"}]})

RUN mongo -u root -p root --authenticationDatabase "admin"

COPY . /app

EXPOSE 3000

CMD ["npm", "start"]
