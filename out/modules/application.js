(function(){var t,e,r,o,s,i=function(t,e){function r(){this.constructor=t}for(var o in e)p.call(e,o)&&(t[o]=e[o]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},p={}.hasOwnProperty;e=require("sublime-core"),o=require("http"),r=require("express"),s=require("morgan"),require("sugar"),t=function(t){function e(t){e.__super__.constructor.call(this,t),this.app=r()}return i(e,t),e.prototype.use=function(t){return t.call(this,this.app)},e.prototype.start=function(t){var e,r,i;return t=t?t:process.env.PORT||this.options.port,this.app.set("port",t),"production"!==process.env.NODE_ENV&&this.app.use(s("dev",{immediate:!0,format:"dev"})),this.options.ssl?(e=require("fs"),r=require("https"),i={key:e.readFileSync(this.options.key),cert:e.readFileSync(this.options.cert)},this.httpServer=r.createServer(i,this.app).listen(t)):this.httpServer=o.createServer(this.app).listen(t)},e}(e.CoreObject),module.exports=t}).call(this);
