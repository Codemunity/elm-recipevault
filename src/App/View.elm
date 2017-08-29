module App.View exposing (..)

import App.Types exposing (..)
import Html exposing (..)
import Login.View as Login
import Login.Types
import SignUp.View as SignUp
import SignUp.Types
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
      div [] [ text "Recipe Search" ]