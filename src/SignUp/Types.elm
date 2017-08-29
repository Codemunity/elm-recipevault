module SignUp.Types exposing (..)

import Auth.Types exposing (Auth)
import Http

type alias Model =
    { emailInput : String
    , nameInput : String
    , passwordInput : String
    , passwordConfirmationInput : String
    , errorMessages : List String
    }

type alias Form =
    { email : String
    , name : String
    , password : String
    , passwordConfirmation : String
    }
    
type Msg
    = NewEmailInput String
    | NewNameInput String
    | NewPasswordInput String
    | NewPasswordConfirmationInput String
    | SignUpFormSubmit
    | SignUpRequestResult (Result Http.Error Auth)
    | NavigateToLogin