# jc.tn URL shortener

# Default recipe - show help
default:
    @just --list

# ─────────────────────────────────────────────────────────────────────────────
# Firebase
# ─────────────────────────────────────────────────────────────────────────────

# Login to Firebase
firebase-login:
    firebase login

# Deploy to Firebase production
deploy-prod: firebase-decrypt
    firebase deploy --only hosting:jc-tn-url-shortener

# Deploy to Firebase beta channel
deploy-beta: firebase-decrypt
    firebase hosting:channel:deploy --only jc-tn-url-shortener beta

# Alias for deploy-beta
deploy: deploy-beta

# ─────────────────────────────────────────────────────────────────────────────
# Cloudflare
# ─────────────────────────────────────────────────────────────────────────────

# Decrypt cloudflare.enc and generate _redirects
cloudflare-decrypt:
    @echo "Decrypting cloudflare.enc and generating _redirects..."
    @sops -d cloudflare.enc | jq -r '.redirects[] | "\(.from) \(.to)"' > .my.cloudflare/_redirects
    @echo "Done! .my.cloudflare/_redirects created"

# Deploy to Cloudflare Pages
cloudflare-deploy: cloudflare-decrypt
    @echo "Deploying to Cloudflare Pages..."
    npx wrangler pages deploy .my.cloudflare --project-name=jc-tn
    @echo "Cloudflare deployment complete!"

# ─────────────────────────────────────────────────────────────────────────────
# Secrets
# ─────────────────────────────────────────────────────────────────────────────

# Decrypt firebase.enc to firebase.json
firebase-decrypt:
    @echo "Decrypting firebase.enc..."
    @sops -d firebase.enc > firebase.json
    @echo "Done! firebase.json created"

# Edit cloudflare redirects (opens in editor)
cloudflare-edit:
    sops cloudflare.enc

# Edit firebase config (opens in editor)
firebase-edit:
    sops firebase.enc
