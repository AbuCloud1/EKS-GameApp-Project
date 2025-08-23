FROM nginx:1.25-alpine AS builder
WORKDIR /app
COPY 2048/ ./

FROM nginx:1.25-alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/ ./
RUN adduser -D appuser
EXPOSE 80
HEALTHCHECK CMD curl -f http://localhost:80/ || exit 1
CMD ["nginx", "-g", "daemon off;"]
