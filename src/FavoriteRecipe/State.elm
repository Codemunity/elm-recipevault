module FavoriteRecipe.State exposing (init, update, subscriptions)

import FavoriteRecipe.Types exposing (..)
import FavoriteRecipe.Rest exposing (..)
import Auth.State as Auth
import Auth.Types exposing (..)
import Error.Rest exposing (..)
import Http exposing (..)
import Navigation

baseApiUrl = "https://recipevault-miguelcodemunity.c9users.io/api"

init : Maybe Auth -> ( Model, Cmd Msg )
init maybeAuth =
  let
    cmd =
      case maybeAuth of
        Just auth ->
          getFavoriteRecipes baseApiUrl auth
        Nothing ->
          Cmd.none
  in
    ( { auth = maybeAuth
      , favoriteRecipes = Nothing
      , errorMessage = Nothing
      }, cmd
    )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case model.auth of
    Just auth ->
      case msg of
        GetFavoriteRecipesResult (Ok recipes) ->
          ( { model | favoriteRecipes = Just recipes }, Cmd.none )
        GetFavoriteRecipesResult (Err error) ->
          case error of
            Http.BadStatus response ->
              ( { model | errorMessage = Just (messageForResponse response) }, Cmd.none )
            _ ->
              ( { model | errorMessage = Just "Unknown error." }, Cmd.none )
        DeleteFavoriteRecipe recipe ->
          ( model, deleteFavoriteRecipe baseApiUrl auth recipe )
        DeleteFavoriteRecipeResult (Ok _) ->
          ( model, getFavoriteRecipes baseApiUrl auth )
        DeleteFavoriteRecipeResult (Err error) ->
          case error of
            Http.BadStatus response ->
              ( { model | errorMessage = Just (messageForResponse response) }, Cmd.none )
            _ ->
              ( { model | errorMessage = Just "Unknown error." }, Cmd.none )
    Nothing ->
      ( model, Navigation.newUrl "#login" )

  
subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none