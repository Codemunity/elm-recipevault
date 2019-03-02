module FavoriteRecipe.Types exposing (..)

import Http

type alias Model =
  { favoriteRecipes : Maybe (List FavoriteRecipe)
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
  = GetFavoriteRecipes
  | GetFavoriteRecipesResult (Result Http.Error (List FavoriteRecipe))
  | DeleteFavoriteRecipe FavoriteRecipe
  | DeleteFavoriteRecipeResult (Result Http.Error String)