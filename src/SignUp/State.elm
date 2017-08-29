module SignUp.State exposing (init, update, subscriptions)

import SignUp.Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { message = "SignUp" }, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none