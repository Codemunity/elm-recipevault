module Auth.Types exposing (..)

import User.Types exposing (User)

type alias Auth =
    { token : String
    , user : User
    }