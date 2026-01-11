# jc.tn - Personal URL Shortener

## Overview

A personal URL shortener deployed to both Firebase Hosting and Cloudflare Pages. Redirects are configured via JSON files encrypted with SOPS.

## Project Structure

```
.
├── public/                   # Static files served by Firebase
│   ├── .well-known/webfinger # OpenID Connect discovery for chaieb.me
│   ├── index.html
│   ├── 404.html
│   └── favicon.ico
├── firebase.enc              # Encrypted Firebase config with redirects
├── cloudflare.enc            # Encrypted Cloudflare redirects
├── justfile                  # Task runner commands
├── wrangler.toml             # Cloudflare Pages configuration
└── .github/workflows/        # CI/CD pipelines
```

## Domains

- **jc.tn**: URL shortener redirects
- **chaieb.me**: Serves `.well-known/webfinger` for OpenID Connect discovery (points to `auth.jacem.ch`)

## Key Technologies

- **Firebase Hosting**: Primary hosting platform
- **Cloudflare Pages**: Secondary hosting platform
- **SOPS**: Secrets encryption (uses AGE and PGP keys)
- **just**: Task runner (replaces Make)
- **release-please**: Automated releases on main branch

## Commands (justfile)

```bash
just                     # Show available commands
just firebase-edit       # Edit firebase.enc (encrypted)
just cloudflare-edit     # Edit cloudflare.enc (encrypted)
just deploy-beta         # Deploy to Firebase beta channel
just deploy-prod         # Deploy to Firebase production
just cloudflare-deploy   # Deploy to Cloudflare Pages
```

## Adding Redirects

### Firebase (firebase.enc)
Edit with `just firebase-edit` or `sops firebase.enc`:
```json
{
  "hosting": {
    "redirects": [
      {
        "source": "/shortcode",
        "destination": "https://example.com/full-url",
        "type": 302
      }
    ]
  }
}
```

### Cloudflare (cloudflare.enc)
Edit with `just cloudflare-edit` or `sops cloudflare.enc`:
```json
{
  "redirects": [
    { "from": "/shortcode", "to": "https://example.com/full-url" }
  ]
}
```

## Deployment Flow

- **Pull Requests**: Auto-deploy to preview environments (Firebase beta + Cloudflare branch)
- **Main branch**: release-please creates release PRs; merging triggers production deployment
- **Manual**: Use `just deploy-prod` or `just cloudflare-deploy`

## Secrets Management

All sensitive config is encrypted with SOPS. The `.sops.yaml` defines encryption keys (AGE + PGP). Never commit decrypted `firebase.json` or `cloudflare.json`.

Required environment variables for CI:
- `SOPS_AGE_KEY`: AGE private key for decryption
- `FIREBASE_SERVICE_ACCOUNT_JACEM_CHAIEB`: Firebase service account
- `CLOUDFLARE_API_TOKEN`: Cloudflare API token
- `CLOUDFLARE_ACCOUNT_ID`: Cloudflare account ID

## URLs

- Production (Firebase): https://jc.tn
- Production (Cloudflare): https://jacem.pages.dev
