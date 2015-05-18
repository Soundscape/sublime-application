(function(){var e,r,t,n,u,i,s,o,c,a;e=require("sublime-core"),a=require("../"),r=require("body-parser"),c=require("helmet"),s=require("csurf"),o=require("express"),r=require("body-parser"),i=require("cookie-parser"),t=require("compression"),u=require("consolidate"),n=require("config"),describe("Application test suite",function(){var e;return e=new a.Application(n.server),it("should construct an instance",function(){return expect(e).not.toBeNull()}),it("should extend an instance",function(){return expect(e).not.toBeNull(),e.use(function(e){return e.use(r.json()),e.use(c.xframe()),e.use(c.hsts())})}),it("should register routes",function(){return expect(e).not.toBeNull(),e.use(function(e){return e.get("/heartbeat",function(e,r){return r.status(200).json("OK")})})}),it("should start an instance",function(){return expect(e).not.toBeNull(),e.start()})})}).call(this);