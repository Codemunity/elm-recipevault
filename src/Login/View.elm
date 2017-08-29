module Login.View exposing (view)

import Html exposing (..)
import Login.Types exposing (..)

view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.message ]
        ]