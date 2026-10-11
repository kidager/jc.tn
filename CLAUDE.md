# jc.tn - Personal URL Shortener

## Overview

A personal URL shortener served by Cloudflare Pages. Redirects are kept in `cloudflare.enc`, encrypted with SOPS.

## Project Structure

```
.
├── public/                   # Static files, copied to dist/
│   ├── .well-known/webfinger # OpenID Connect discovery for chaieb.me
│   ├── _headers              # Cloudflare Pages headers
│   ├── index.html
│   ├── 404.html
│   └── favicon.ico
├── cloudflare.enc            # Encrypted redirects
├── justfile                  # Task runner commands
├── wrangler.toml             # Cloudflare Pages configuration
└── .github/                  # CI/CD (build action, preview and release workflows)
```

## Commands (justfile)

```bash
just          # Show available commands
just edit     # Edit cloudflare.enc (encrypted)
just build    # Build dist/ (public/ + _redirects)
just dev      # Serve dist/ locally with wrangler
just deploy   # Deploy to Cloudflare Pages
```

## Adding Redirects

Edit with `just edit`:
```json
{
  "redirects": [
    { "from": "/shortcode", "to": "https://example.com/full-url" }
  ]
}
```

Each entry becomes a `_redirects` line. Redirects take priority over the files in `public/`.

## Deployment Flow

- **Pull Requests**: deployed to a Cloudflare Pages preview branch
- **Releases**: kidager-bot opens the release PR; the published release deploys to production

Never commit decrypted secrets.
