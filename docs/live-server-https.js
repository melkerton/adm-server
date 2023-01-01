var fs = require("fs");

module.exports = {
	cert: fs.readFileSync("/opt/letsencrypt/kadev.app/fullchain.pem"),
	key: fs.readFileSync("/opt/letsencrypt/kadev.app/privkey.pem"),
};