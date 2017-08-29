module Login.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Login.Types exposing (..)
import Maybe

view : Model -> Html Msg
view model =
    div []
        [ div [ style [ ("color", "red") ] ] [ text (Maybe.withDefault "" model.errorMessage) ]
        , div [] [ input [ type_ "text", placeholder "Email", onInput NewEmailInput, value model.emailInput ] [] ]
        , div [] [ input [ type_ "password", placeholder "Password", onInput NewPasswordInput, value model.passwordInput ] [] ]
        , div [] [ button [ onClick LoginFormSubmit ] [ text "Login" ] ]
        , div [] [ a [ onClick NavigateToSignUp ] [ text "Don't have an account? Click here to sign up!" ] ]
        ]