module App.View exposing (..)

import App.Types exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
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
      case model.flags.auth of
        Just auth ->
          div [] 
            [ div [] [ h1 [] [ text "Recipe Search" ] ]
            , div [] [ text ( "Welcome " ++ auth.user.name ++ "!" ) ]
            , div [] [ a [ onClick Logout ] [ text "Logout" ] ]
            ]
        Nothing ->
          div [] 
            [ div [] [ h1 [] [ text "Recipe Search" ] ]
            , div [] [ a [ onClick Logout ] [ text "Logout" ] ]
            ]