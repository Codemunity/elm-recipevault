module SignUp.Rest exposing (..)

import Http
import Json.Encode
import SignUp.Types exposing (..)
import Auth.Rest exposing (..)

signUpRequest : String -> Form -> Cmd Msg
signUpRequest baseApiUrl form =
  let
      requestUrl =
        baseApiUrl ++ "/users"
      encodedForm =
        encodeForm form
      requestBody =
        Http.jsonBody encodedForm
      request =
        Http.post requestUrl requestBody decodeAuth
  in
      Http.send SignUpRequestResult request

encodeForm : Form -> Json.Encode.Value
encodeForm form =
  Json.Encode.object
    [ ( "email" , Json.Encode.string form.email)
    , ( "name" , Json.Encode.string form.name)
    , ( "password" , Json.Encode.string form.password)
    ]