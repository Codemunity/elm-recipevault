module RecipeSearch.Types exposing (..)

import Http
import Recipe.Types exposing (..)

type alias Model =
  { query : String
  , chosenDietLabel : Maybe String
  , chosenHealthLabel : Maybe String
  , allDietLabels : List String
  , allHealthLabels : List String
  , errorMessage : Maybe String
  , hits : Maybe Hits
  }

type alias Hits =
  { count : Int
  , hasMore : Bool
  , hits : List Hit
  }

type alias Hit =
  { recipe : Recipe
  }
  
type Msg
  = NewQuery String
  | OnDietSelected String
  | OnHealthSelected String
  | SearchRecipes
  | SearchRecipesResult (Result Http.Error Hits)
  | Logout