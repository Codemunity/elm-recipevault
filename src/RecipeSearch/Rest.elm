module RecipeSearch.Rest exposing (..)

import Http
import Json.Decode
import Json.Decode.Pipeline exposing (..)
import RecipeSearch.Types exposing (..)
import Recipe.Rest exposing (..)
import FavoriteRecipe.Types exposing (FavoriteRecipe)
import FavoriteRecipe.Rest exposing (..)

-- Replace the APP_ID and APP_KEY placeholders with your actual values
recipeApiUrl = "https://api.edamam.com/search?app_id=0c69de46&app_key=e22efceb245b15e61f0586491d062c58"

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
    
createFavoriteRecipe : String -> Auth -> FavoriteRecipe -> Cmd Msg
createFavoriteRecipe baseApiUrl auth recipe =
  let
      requestUrl =
        baseApiUrl ++ "/recipes"
      encodedFavoriteRecipe =
        encodeFavoriteRecipe recipe
      requestBody =
        Http.jsonBody encodedFavoriteRecipe
      request =
        Http.request
          { method = "POST"
          , headers = [ ("Authorization", auth.token) ]
          , url = requestUrl
          , body = requestBody
          , expect = Http.expectJson decodeFavoriteRecipe
          , timeout = Nothing
          , withCredentials = False
          }
  in
      Http.send CreateF request