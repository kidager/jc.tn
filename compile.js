'use strict';

const fs = require('fs');

let firebaseConfig = {
    hosting: {
        site: "jc-tn-url-shortener",
        public: "public",
        ignore: [
            "firebase.json",
            "**/.*",
            "**/node_modules/**"
        ],
        redirects: [
            { source: "/", destination: "https://jacem.chaieb.me", type: 301 }
        ],
        rewrites: [
            { source: "/favicon.ico", destination: "/favicon.ico" },
            { source: "/robots.txt", destination: "/robots.txt" },
            { source: "**", destination: "/404.htm" }
        ],
        cleanUrls: true,
        trailingSlash: false
    }
};


try {
    let redirectsJson = fs.readFileSync('redirects.json');
    firebaseConfig.hosting.redirects = JSON.parse(redirectsJson.toString());
    fs.writeFileSync('firebase.json', JSON.stringify(firebaseConfig), 'utf8');
} catch (err) {
    console.error('Error encountered', err);
    process.exit(1);
}
