module FavoriteRecipe.Types exposing (..)

import Http
import Auth.Types exposing (..)

type alias Model =
  { auth: Maybe Auth
  , favoriteRecipes : Maybe (List FavoriteRecipe)
  , errorMessage : Maybe String
  }
  
type alias FavoriteRecipe =
  { label : String
  , image : String
  , url : String
  , calories : Float
  , source : String
  }
  
type Msg
  = GetFavoriteRecipesResult (Result Http.Error (List FavoriteRecipe))
  | DeleteFavoriteRecipe FavoriteRecipe
  | DeleteFavoriteRecipeResult (Result Http.Error String)