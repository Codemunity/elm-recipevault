module SignUp.State exposing (init, update, subscriptions)

import SignUp.Types exposing (..)
import SignUp.Rest exposing (..)
import Http exposing (..)
import Navigation


init : ( Model, Cmd Msg )
init =
    ( { emailInput = "", nameInput = "", passwordInput = "", passwordConfirmationInput = "", errorMessages = [] }, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewEmailInput newEmail ->
            ( { model | emailInput = newEmail }, Cmd.none )
        NewNameInput newName ->
            ( { model | nameInput = newName }, Cmd.none )
        NewPasswordInput newPassword ->
            ( { model | passwordInput = newPassword }, Cmd.none )
        NewPasswordConfirmationInput newPassword ->
            ( { model | passwordConfirmationInput = newPassword }, Cmd.none )
        SignUpFormSubmit ->
            let
                form =
                    Form model.emailInput model.nameInput model.passwordInput model.passwordConfirmationInput
            in
                ( model, signUpRequest "https://recipevault-miguelcodemunity.c9users.io/api" form )
        SignUpRequestResult (Ok auth) ->
            ( model, Navigation.newUrl "#recipe-search" )
        SignUpRequestResult (Err error) ->
            case error of
                Http.BadStatus response ->
                    ( { model | errorMessages = [ "Bad request." ] }, Cmd.none )
                _ ->
                    ( { model | errorMessages = [ "Unknown error." ] }, Cmd.none )
        NavigateToLogin ->
            ( model, Navigation.newUrl "#login" )

subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none