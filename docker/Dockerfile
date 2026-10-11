FROM node:26-trixie-slim AS node

FROM ubuntu:26.04

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN apt-get update \
  && apt-get install -y --no-install-recommends libatomic1 ca-certificates \
  && rm -rf /var/lib/apt/lists/* \
  && ln -s ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -s ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
  && npm install -g wrangler

WORKDIR /app

ENTRYPOINT ["wrangler"]
CMD ["pages", "dev", "dist", "--ip", "0.0.0.0", "--port", "8788"]
EXPOSE 8788
