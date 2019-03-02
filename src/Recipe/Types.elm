module Recipe.Types exposing (..)

type alias Recipe =
  { title : String
  , image : String
  , url : String
  , servings : Int
  , calories : Float
  , ingredients : List String
  , dietLabels: List String
  , healthLabels: List String
  , source : String
  }