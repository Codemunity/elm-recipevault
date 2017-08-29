module App.State exposing (init, update, subscriptions)

import App.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { message = "Your Elm App is working!" }, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none