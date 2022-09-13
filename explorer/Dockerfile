FROM node:latest

WORKDIR /home/nervos

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/nervosnetwork/ckb-explorer-frontend.git
RUN for i in $(ls -d ckb-explorer-frontend/.*);do test -f $i && mv -v $i ./; done;
RUN mv ckb-explorer-frontend/* .
RUN yarn install

RUN echo "CKB_NODE_URL=http://node:8114" > .env.develop
RUN echo "REACT_APP_CHAIN_TYPE=mainnet" > .env.develop
RUN echo "REACT_APP_MAINNET_URL=http://localhost:3000" >> .env.develop
RUN echo "REACT_APP_TESTNET_NAME=mainnet" >> .env.develop
ENV NODE_OPTIONS=--openssl-legacy-provider

ADD ./docker-entrypoint.sh .

ENTRYPOINT ["/home/nervos/docker-entrypoint.sh"]
