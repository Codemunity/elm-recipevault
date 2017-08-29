module Login.Types exposing (..)

import Auth.Types exposing (Auth)
import Http

type alias Model =
    { emailInput : String
    , passwordInput : String
    , errorMessage : Maybe String
    }
    
type alias Credentials =
    { email : String
    , password : String
    }
    
type Msg
    = NewEmailInput String
    | NewPasswordInput String
    | LoginFormSubmit
    | LoginRequestResult (Result Http.Error Auth)
    | NavigateToSignUp