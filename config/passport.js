// const GoogleStrategy = require('passport-google-oauth20').Strategy
const mongoose = require('mongoose')
const User = require('../models/User');
var { Strategy } = require('passport-openidconnect');

module.exports = function (passport) {
  passport.use('oidc', new Strategy({
    issuer: `https://${process.env.OKTA_DOMAIN}/oauth2/default`,
    authorizationURL: `https://${process.env.OKTA_DOMAIN}/oauth2/default/v1/authorize`,
    tokenURL: `https://${process.env.OKTA_DOMAIN}/oauth2/default/v1/token`,
    userInfoURL: `https://${process.env.OKTA_DOMAIN}/oauth2/default/v1/userinfo`,
    clientID: process.env.OAUTH_CLIENT_ID,
    clientSecret: process.env.OAUTH_CLIENT_SECRET,
    callbackURL: process.env.OAUTH_CALLBACK_URL,
    scope: 'openid profile'
  }, (issuer, profile, done) => {
    return done(null, profile);
  }));
  
  passport.serializeUser((user, next) => {
    next(null, user);
  });
  
  passport.deserializeUser((obj, next) => {
    next(null, obj);
  });

}
