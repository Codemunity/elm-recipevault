module FavoriteRecipe.Rest exposing (..)

import Http
import Json.Encode
import Json.Decode
import Auth.Types exposing (..)
import Json.Decode.Pipeline exposing (..)
import FavoriteRecipe.Types exposing (..)
      
getFavoriteRecipes : String -> Auth -> Cmd Msg
getFavoriteRecipes baseApiUrl auth =
  let
    requestUrl =
      baseApiUrl ++ "/recipes"
    request =
      Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" auth.token ]
        , url = requestUrl
        , body = Http.emptyBody
        , expect = Http.expectJson (Json.Decode.list decodeFavoriteRecipe)
        , timeout = Nothing
        , withCredentials = False
        }
  in
    Http.send GetFavoriteRecipesResult request

deleteFavoriteRecipe : String -> Auth -> FavoriteRecipe -> Cmd Msg
deleteFavoriteRecipe baseApiUrl auth recipe =
  let
      requestUrl =
        baseApiUrl ++ "/recipes"
      encodedFavoriteRecipe =
        encodeFavoriteRecipe recipe
      requestBody =
        Http.jsonBody encodedFavoriteRecipe
      request =
      Http.request
        { method = "DELETE"
        , headers = [ Http.header "Authorization" auth.token ]
        , url = requestUrl
        , body = requestBody
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }
  in
      Http.send DeleteFavoriteRecipeResult request

decodeFavoriteRecipe : Json.Decode.Decoder FavoriteRecipe
decodeFavoriteRecipe =
  decode FavoriteRecipe
    |> required "label" Json.Decode.string
    |> required "image" Json.Decode.string
    |> required "url" Json.Decode.string
    |> required "calories" Json.Decode.float
    |> required "source" Json.Decode.string

encodeFavoriteRecipe : FavoriteRecipe -> Json.Encode.Value
encodeFavoriteRecipe recipe =
  Json.Encode.object
    [ ( "label" , Json.Encode.string recipe.label)
    , ( "image" , Json.Encode.string recipe.image)
    , ( "url" , Json.Encode.string recipe.url)
    , ( "calories" , Json.Encode.float recipe.calories)
    , ( "source" , Json.Encode.string recipe.source)
    ]
