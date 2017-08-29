module SignUp.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import SignUp.Types exposing (..)

view : Model -> Html Msg
view model =
    div []
        [ div [] [ errorsView model.errorMessages ]
        , div [] [ input [ type_ "text", placeholder "Email", onInput NewEmailInput, value model.emailInput ] [] ]
        , div [] [ input [ type_ "text", placeholder "Name", onInput NewNameInput, value model.nameInput ] [] ]
        , div [] [ input [ type_ "password", placeholder "Password", onInput NewPasswordInput, value model.passwordInput ] [] ]
        , div [] [ input [ type_ "password", placeholder "Confirm Password", onInput NewPasswordConfirmationInput, value model.passwordConfirmationInput ] [] ]
        , div [] [ button [ onClick SignUpFormSubmit ] [ text "Sign Up" ] ]
        , div [] [ a [ onClick NavigateToLogin ] [ text "Already signed up? Click here to log in!" ] ]
        ]
        
errorsView : List String -> Html Msg
errorsView errors =
    ul [ style [ ("color", "red") ] ] (List.map errorView errors)
    
errorView : String -> Html Msg
errorView error =
    li [] [ text error ]