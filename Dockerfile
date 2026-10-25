FROM node:22-slim
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*
WORKDIR /src
COPY nova-transit.zip .
RUN unzip -q nova-transit.zip && mv nova-transit /app && rm nova-transit.zip
WORKDIR /app
RUN npm ci --omit=dev
ENV NODE_ENV=production DATA_DIR=/data
RUN mkdir -p /data
EXPOSE 3000
CMD ["node","server/index.js"]
