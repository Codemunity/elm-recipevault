require('./main.css')
var Elm = require('./RecipeVault.elm')

var root = document.getElementById('root')

var storedState = localStorage.getItem('auth');
var auth = storedState ? JSON.parse(storedState) : null;

var flags = {
    auth
}

var elmApp = Elm.RecipeVault.embed(root, flags);

elmApp.ports.setAuth.subscribe(function(state) {
    localStorage.setItem('auth', JSON.stringify(state));
});

elmApp.ports.clearAuth.subscribe(function() {
    localStorage.removeItem('auth');
    elmApp.ports.authCleared.send(null);
});