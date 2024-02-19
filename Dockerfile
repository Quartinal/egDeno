FROM denoland/deno:latest

COPY . .

CMD ["deno", "run", "--allow-net", "--allow-read", "--allow-write", "index.mts"]