module RecipeSearch.Rest exposing (..)

import Http
import Json.Decode
import Json.Decode.Pipeline exposing (..)
import RecipeSearch.Types exposing (..)
import Recipe.Rest exposing (..)

-- Replace the APP_ID and APP_KEY placeholders with your actual values
recipeApiUrl = "https://api.edamam.com/search?app_id=APP_ID&app_key=APP_KEY"

searchRecipes : String -> Maybe String -> Maybe String -> Cmd Msg
searchRecipes query chosenDietLabel chosenHealthLabel =
  let
    dietParam =
      case chosenDietLabel of
        Just label ->
          "&diet=" ++ label
        Nothing ->
          ""
    healthParam =
      case chosenHealthLabel of
        Just label ->
          "&health=" ++ label
        Nothing ->
          ""
    requestUrl =
      recipeApiUrl ++ "&q=" ++ query ++ dietParam ++ healthParam
    request =
      Http.request
        { method = "GET"
        , headers = []
        , url = requestUrl
        , body = Http.emptyBody
        , expect = Http.expectJson decodeHits
        , timeout = Nothing
        , withCredentials = False
        }
  in
    Http.send SearchRecipesResult request


decodeHits : Json.Decode.Decoder Hits
decodeHits =
  decode Hits
    |> required "count" Json.Decode.int
    |> required "more" Json.Decode.bool
    |> required "hits" (Json.Decode.list decodeHit)
    
    
decodeHit : Json.Decode.Decoder Hit
decodeHit =
  decode Hit
    |> required "recipe" decodeRecipe