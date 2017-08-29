module Error.Types exposing (..)

type alias ApiError =
    { code : Int
    , message : String
    }