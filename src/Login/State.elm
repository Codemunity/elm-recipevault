module Login.State exposing (init, update, subscriptions)

import Login.Types exposing (..)
import Login.Rest exposing (..)
import Http exposing (..)
import Navigation


init : ( Model, Cmd Msg )
init =
    ( { emailInput = "", passwordInput = "", errorMessage = Nothing }, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewEmailInput newEmail ->
            ( { model | emailInput = newEmail }, Cmd.none )
        NewPasswordInput newPassword ->
            ( { model | passwordInput = newPassword }, Cmd.none )
        LoginFormSubmit ->
            let
                credentials =
                    Credentials model.emailInput model.passwordInput
            in
                ( model, loginRequest "https://<workspacename>-<username>.c9users.io/api" credentials )
        LoginRequestResult (Ok auth) ->
            ( model, Navigation.newUrl "#recipe-search" )
        LoginRequestResult (Err error) ->
            case error of
                Http.BadStatus response ->
                    ( { model | errorMessage = Just "Bad request." }, Cmd.none )
                _ ->
                    ( { model | errorMessage = Just "Unknown error." }, Cmd.none )
        NavigateToSignUp ->
            ( model, Navigation.newUrl "#signup" )

subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none
