module RecipeVault exposing (main)

import Html
import App.Types exposing (..)
import App.View exposing (view)
import App.State exposing (init, update, subscriptions)

main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }