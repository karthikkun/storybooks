const express = require('express')
const passport = require('passport')
const router = express.Router()

function ensureLoggedIn(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.redirect('/login')
}

router.get('/login', passport.authenticate('oidc'));

router.get('/oauth2/callback', passport.authenticate('oidc', { failureRedirect: '/error' }),
  (req, res) => {
    res.redirect('/profile');
  }
);

router.get('/profile', ensureLoggedIn, (req, res) => {
  res.render('profile', { title: 'Express', user: req.user });
});

router.get('/logout', (req, res) => {
  req.logout();
  req.session.destroy();
  res.redirect('/');
});

module.exports = router
