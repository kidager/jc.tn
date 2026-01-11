# jc.tn

Personal URL shortener and static file server deployed to Firebase Hosting and Cloudflare Pages.

## Features

- **URL Shortener**: Redirect rules for jc.tn domain
- **WebFinger**: OpenID Connect discovery for chaieb.me domain (`/.well-known/webfinger`)

## Dev mode

### Requirements

- [git](https://git-scm.com/)
- [sops](https://github.com/mozilla/sops)


### Clone the repository

```bash
git clone git@github.com:kidager/jc.tn.git
cd jc.tn
```


### Edit config file

```bash
# To edit redirections you'll need to edit `firebase.enc` with `sops`
sops firebase.enc
```

You will be editing `hosting.redirects` array.:
```json
{
    "hosting": {
        "redirects": [
            // ...
            {
                "source": "/",
                "destination": "https://jacem.chaieb.me",
                "type": 301
            },
            // ...
        ]
    }
}
```


## Deploy

```bash
# To deploy you'll need to push the code to the remote repository
# - <master> => production
# - <develop> => beta
# - any open PR => temp-deployment

git push
```

or if you want to deploy from your local env, you will need to install firebase and then run the following commands
```bash
# Decrypt the config file
sops --decrypt firebase.enc > firebase.json

# You may need to login your google account before deploy
make firebase-login

# Deploy to prod
make deploy-prod
# or to beta
make deploy-beta
```


## License
[UNLICENSE](https://unlicense.org/)
