module FavoriteRecipe.State exposing (init, update, subscriptions)

import FavoriteRecipe.Types exposing (..)
import FavoriteRecipe.Rest exposing (..)
import Auth.State as Auth
import Auth.Types exposing (..)

init : ( Model, Cmd Msg )
init =
  ( { favoriteRecipes = Nothing
    , errorMessage = Nothing
    }, Cmd.none
  )
  
update : Auth -> Msg -> Model -> ( Model, Cmd Msg )
update auth msg model =
  ( model, Cmd.none )
  
subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none