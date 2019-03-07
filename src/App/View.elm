module App.View exposing (..)

import App.Types exposing (..)
import Html exposing (..)
import Login.View as Login
import SignUp.View as SignUp
import RecipeSearch.View as RecipeSearch
import FavoriteRecipe.View as FavoriteRecipe
import Routing.Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ page model ]

page : Model -> Html Msg
page model =
  case model.currentRoute of
    LoginRoute ->
      Html.map LoginMsg (Login.view model.loginModel)
    SignUpRoute ->
      Html.map SignUpMsg (SignUp.view model.signUpModel)
    RecipeSearchRoute ->
      Html.map RecipeSearchMsg (RecipeSearch.view model.recipeSearchModel)
    FavoriteRecipeRoute ->
      Html.map FavoriteRecipeMsg (FavoriteRecipe.view model.favoriteRecipeModel)