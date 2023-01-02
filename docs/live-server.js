var liveServer = require("live-server");

/*
var params = {
	port: 21212, // Set the server port. Defaults to 8080.
	host: "0.0.0.0", // Set the address to bind to. Defaults to 0.0.0.0 or process.env.IP.
	root: "../build/html", // Set root directory that's being served. Defaults to cwd.
	open: false, // When false, it won't load your browser by default.
	file: "index.html", // When set, serve this file (server root relative) for every 404 (useful for single-page applications)
	wait: 1000, // Waits for all changes, before reloading. Defaults to 0 sec.
	//mount: [['/components', './node_modules']], // Mount a directory to a route.
	//logLevel: 2, // 0 = errors only, 1 = some, 2 = lots
	//middleware: [function(req, res, next) { next(); }] // Takes an array of Connect-compatible middleware that are injected into the server middleware stack
};
liveServer.start(params);
*/

var params = {
	port: 8081,
	host: "vsc.kadev.app",
	root: "build/html", 
	open: false, 
	file: "index.html", 
	https: '/opt/letsencrypt/kadev.app/live-server-https.js'
};

liveServer.start(params);