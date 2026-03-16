# Stage 1
FROM debian:bullseye-slim AS builder

RUN apt-get update && \
    apt-get install -y cowsay fortune-mod netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Stage 2 
FROM debian:bullseye-slim

WORKDIR /app

COPY --from=builder /usr/games/cowsay /usr/games/cowsay
COPY --from=builder /usr/games/fortune /usr/games/fortune
COPY --from=builder /bin/nc /bin/nc

COPY wisecow.sh .

RUN chmod +x wisecow.sh

EXPOSE 4499

CMD ["sh","wisecow.sh"]