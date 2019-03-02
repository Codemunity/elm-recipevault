module Recipe.Rest exposing (..)

import Json.Decode
import Json.Decode.Pipeline exposing (..)
import Recipe.Types exposing (..)

decodeRecipe : Json.Decode.Decoder Recipe
decodeRecipe =
  decode Recipe
    |> required "label" Json.Decode.string
    |> required "image" Json.Decode.string
    |> required "url" Json.Decode.string
    |> required "yield" Json.Decode.int
    |> required "calories" Json.Decode.float
    |> required "ingredientLines" (Json.Decode.list Json.Decode.string)
    |> required "dietLabels" (Json.Decode.list Json.Decode.string)
    |> required "healthLabels" (Json.Decode.list Json.Decode.string)
    |> required "source" Json.Decode.string
