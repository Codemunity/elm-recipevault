module Error.Rest exposing (..)

import Json.Decode
import Json.Decode.Pipeline exposing (..)
import Error.Types exposing (..)
import Http

decodeApiError : Json.Decode.Decoder ApiError
decodeApiError =
  decode ApiError
    |> required "code" Json.Decode.int
    |> required "message" Json.Decode.string
    
extractErrorMessage : String -> String
extractErrorMessage json =
  let
      result =
        Json.Decode.decodeString decodeApiError json
  in
      case result of
        (Ok error) ->
          error.message
        (Err error) ->
          "Unknown error, please notify it."
          
messageForResponse : Http.Response String -> String
messageForResponse response =
  extractErrorMessage response.body