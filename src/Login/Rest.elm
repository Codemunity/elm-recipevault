module Login.Rest exposing (..)

import Http
import Json.Encode
import Login.Types exposing (..)
import Auth.Rest exposing (..)

loginRequest : String -> Credentials -> Cmd Msg
loginRequest baseApiUrl credentials =
  let
      requestUrl =
        baseApiUrl ++ "/auth"
      encodedCredentials =
        encodeCredentials credentials
      requestBody =
        Http.jsonBody encodedCredentials
      request =
        Http.post requestUrl requestBody decodeAuth
  in
      Http.send LoginRequestResult request

encodeCredentials : Credentials -> Json.Encode.Value
encodeCredentials credentials =
  Json.Encode.object
    [ ( "email" , Json.Encode.string credentials.email)
    , ( "password" , Json.Encode.string credentials.password)
    ]