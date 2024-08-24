FROM node:20-alpine@sha256:1a526b97cace6b4006256570efa1a29cd1fe4b96a5301f8d48e87c5139438a45

WORKDIR /home/node/app

RUN npm install -g superstatic

ENTRYPOINT ["superstatic"]
CMD [".", "--port", "8080", "--host", "0.0.0.0", "--debug"]
EXPOSE 8080
