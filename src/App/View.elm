module App.View exposing (view)

import Html exposing (..)
import App.Types exposing (..)

view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.message ]
        ]