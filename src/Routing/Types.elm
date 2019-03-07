module Routing.Types exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)

type Route
  = LoginRoute
  | SignUpRoute
  | RecipeSearchRoute
  | FavoriteRecipeRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map LoginRoute (s "login")
        , map SignUpRoute (s "signup")
        , map RecipeSearchRoute (s "recipe-search")
        , map FavoriteRecipeRoute (s "favorite-recipes")
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        Nothing ->
            LoginRoute