module Login.State exposing (init, update, subscriptions)

import Login.Types exposing (..)
import Login.Rest exposing (..)
import Http exposing (..)
import Navigation
import Error.Types exposing (..)
import Error.Rest exposing (..)
import Auth.Types exposing (..)
import Auth.State as Auth


init : ( Model, Cmd Msg )
init =
    ( { emailInput = "", passwordInput = "", errorMessage = Nothing }, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg, Maybe Auth )
update msg model =
  case msg of
    NewEmailInput newEmail ->
      ( { model | emailInput = newEmail }, Cmd.none, Nothing )
    NewPasswordInput newPassword ->
      ( { model | passwordInput = newPassword }, Cmd.none, Nothing )
    LoginFormSubmit ->
      let
        credentials =
          Credentials model.emailInput model.passwordInput
        request =
          loginRequest "https://recipevault-miguelcodemunity.c9users.io/api" credentials
      in
        ( { model | errorMessage = Nothing }, request, Nothing )
    LoginRequestResult (Ok auth) ->
      ( model, Cmd.batch [ Auth.set auth, Navigation.newUrl "#recipe-search" ], Just auth )
    LoginRequestResult (Err error) ->
      case error of
        Http.BadStatus response ->
          ( { model | errorMessage = Just (messageForResponse response) }, Cmd.none, Nothing )
        _ ->
          ( { model | errorMessage = Just "Unknown error." }, Cmd.none, Nothing )
    NavigateToSignUp ->
      ( model, Navigation.newUrl "#signup", Nothing )

subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none
