module Login.State exposing (init, update, subscriptions)

import Login.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { message = "Login" }, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none