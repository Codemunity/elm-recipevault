module RecipeVault exposing (main)

import App.Types exposing (..)
import App.View exposing (..)
import App.State exposing (..)
import Navigation exposing (Location)


main : Program Never Model Msg
main =
  Navigation.program OnLocationChange
    { view = view
    , init = init
    , update = update
    , subscriptions = subscriptions
    }
