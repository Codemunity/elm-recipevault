require('./main.css')
var Elm = require('./RecipeVault.elm')

var root = document.getElementById('root')

var auth = null
// var auth = {
//     token: "token-api",
//     user: { 
//         email: "email@email.com",
//         password : "password",
//         name : "Name"
//     }
// }

var flags = {
    auth
}

Elm.RecipeVault.embed(root, flags)