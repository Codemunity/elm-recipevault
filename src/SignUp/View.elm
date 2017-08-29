module SignUp.View exposing (view)

import Html exposing (..)
import SignUp.Types exposing (..)

view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.message ]
        ]