FROM denoland/deno:latest

COPY . .

CMD ["deno", "run", "--allow-net", "index.mts"]