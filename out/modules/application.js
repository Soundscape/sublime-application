(function(){var e,r,t,s,i,o,n,u,p,a,c,h=function(e,r){function t(){this.constructor=e}for(var s in r)l.call(r,s)&&(e[s]=r[s]);return t.prototype=r.prototype,e.prototype=new t,e.__super__=r.prototype,e},l={}.hasOwnProperty;r=require("sublime-core"),a=require("http"),u=require("express"),c=require("morgan"),t=require("body-parser"),p=require("helmet"),n=require("csurf"),o=require("cookie-parser"),s=require("compression"),i=require("consolidate"),require("sugar"),e=function(e){function r(e){null==e&&(e={}),r.__super__.constructor.call(this,e),this.app=u()}return h(r,e),r.prototype.use=function(e){return e.call(this,this.app),this},r.prototype.start=function(e){var r,n,p;return e=e?e:process.env.PORT||this.options.port,this.app.set("port",e),"production"!==process.env.NODE_ENV&&this.app.use(c("dev",{immediate:!0,format:"dev"})),this.options.ssl?(r=require("fs"),n=require("https"),p={key:r.readFileSync(this.options.key),cert:r.readFileSync(this.options.cert)},this.httpServer=n.createServer(p,this.app).listen(e)):this.httpServer=a.createServer(this.app).listen(e),{useDefaults:function(){var e;return e=function(e){return e.cookieParser=o(),e.engine("html",i.handlebars),e.set("view engine","html"),e.set("views","./out/views"),e.use(t.json()),e.use(t.urlencoded({extended:!0})),e.use(e.cookieParser),e.use(s())},this.use(e)},router:function(e,r){var t;return t=u.Router(),r.apply(this,t),this.app.use("/api",t),this}}},r}(r.CoreObject),module.exports=e}).call(this);
