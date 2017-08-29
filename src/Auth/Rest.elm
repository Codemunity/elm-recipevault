module Auth.Rest exposing (..)

import Json.Decode
import Json.Decode.Pipeline exposing (..)
import Auth.Types exposing (..)
import User.Rest exposing (..)

decodeAuth : Json.Decode.Decoder Auth
decodeAuth =
  decode Auth
    |> required "token" Json.Decode.string
    |> required "user" decodeUser