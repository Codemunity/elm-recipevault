module User.Rest exposing (..)

import Json.Encode
import Json.Decode
import Json.Decode.Pipeline exposing (..)
import User.Types exposing (..)

encodeUser : User -> Json.Encode.Value
encodeUser user =
  Json.Encode.object
    [ ( "email" , Json.Encode.string user.email)
    , ( "password" , Json.Encode.string user.password)
    , ( "name" , Json.Encode.string user.name)
    ]

decodeUser : Json.Decode.Decoder User
decodeUser =
  decode User
    |> required "email" Json.Decode.string
    |> required "password" Json.Decode.string
    |> required "name" Json.Decode.string