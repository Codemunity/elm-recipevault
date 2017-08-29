module App.Types exposing (..)

import Navigation exposing (Location)
import Routing.Types exposing (..)
import Login.Types
import SignUp.Types

type alias Model =
    { loginModel : Login.Types.Model
    , signUpModel : SignUp.Types.Model
    , currentRoute : Route
    }

type Msg
    = LoginMsg Login.Types.Msg
    | SignUpMsg SignUp.Types.Msg
    | OnLocationChange Location