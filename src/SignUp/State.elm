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
            let
                updatedModel =
                    { model | emailInput = newEmail }
            in
                ( { updatedModel | errorMessages = validateModel updatedModel }, Cmd.none )
        NewNameInput newName ->
            let
                updatedModel =
                    { model | nameInput = newName }
            in
            ( { updatedModel | errorMessages = validateModel updatedModel }, Cmd.none )
        NewPasswordInput newPassword ->
            let
                updatedModel =
                    { model | passwordInput = newPassword }
            in
                ( { updatedModel | errorMessages = validateModel updatedModel }, Cmd.none )
        NewPasswordConfirmationInput newPassword ->
            let
                updatedModel =
                    { model | passwordConfirmationInput = newPassword }
            in
                ( { updatedModel | errorMessages = validateModel updatedModel }, Cmd.none )
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


-- VALIDATIONS

isEmailValid : String -> String
isEmailValid email =
    if String.contains "@" email then "" else "Please enter a valid email."
    
isNameValid : String -> String
isNameValid name =
    if String.length name > 0 then "" else "Please enter a name."
    
isPasswordValid : String -> String
isPasswordValid pass =
    if String.length pass > 5 then "" else "The password must have at least 6 characters."
    
isPasswordConfirmationValid : String -> String -> String
isPasswordConfirmationValid pass passConf =
    if pass == passConf then "" else "The passwords do not match."
    
validateModel : Model -> List String
validateModel model =
    let
        emailError =
            isEmailValid model.emailInput
        nameError =
            isNameValid model.nameInput
        passwordError =
            isPasswordValid model.passwordInput
        passwordConfirmationError =
            isPasswordConfirmationValid model.passwordInput model.passwordConfirmationInput
        errors =
            [ emailError, nameError, passwordError, passwordConfirmationError ]
    in
        List.filter (\e -> not (String.isEmpty e)) errors