# jc.tn URL shortener

# Default recipe - show help
default:
    @just --list

# Build dist/ from public/ and the redirects in cloudflare.enc
build:
    rm -rf dist
    cp -r public dist
    sops -d cloudflare.enc | jq -r '.redirects[] | "\(.from) \(.to)"' > dist/_redirects

# Serve dist/ locally
dev: build
    docker compose up

# Deploy to Cloudflare Pages
deploy: build
    npx wrangler pages deploy dist --project-name=jacem --branch=main

# Edit the redirects (opens in editor)
edit:
    sops cloudflare.enc
