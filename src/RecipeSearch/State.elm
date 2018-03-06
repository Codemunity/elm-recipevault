module RecipeSearch.State exposing (init, update, subscriptions)

import RecipeSearch.Types exposing (..)
import RecipeSearch.Rest exposing (..)
import Auth.State as Auth

allDietLabels : List String
allDietLabels = 
  [ "balanced"
  , "high-fiber"
  , "high-protein"
  , "low-carb"
  , "low-fat"
  ]
  
allHealthLabels : List String
allHealthLabels =
  [ "vegan"
  , "vegetarian"
  , "sugar-conscious"
  , "peanut-free"
  , "tree-nut-free"
  , "alcohol-free"
  ]

init : ( Model, Cmd Msg )
init =
    ( { query = ""
      , chosenDietLabel = Nothing
      , chosenHealthLabel = Nothing
      , allDietLabels = allDietLabels
      , allHealthLabels = allHealthLabels
      , errorMessage = Nothing
      , hits = Nothing
      }, Cmd.none 
    )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NewQuery newQuery ->
      ( { model | query = newQuery }, Cmd.none )
    OnDietSelected dietLabel ->
      if dietLabel == (Maybe.withDefault "" model.chosenDietLabel) then
        ( { model | chosenDietLabel = Nothing }, Cmd.none )
      else
        ( { model | chosenDietLabel = Just dietLabel }, Cmd.none )
    OnHealthSelected healthLabel ->
      if healthLabel == (Maybe.withDefault "" model.chosenHealthLabel) then
        ( { model | chosenHealthLabel = Nothing }, Cmd.none )
      else
        ( { model | chosenHealthLabel = Just healthLabel }, Cmd.none )
    SearchRecipes ->
      if String.isEmpty model.query then
        ( { model | errorMessage = Just "Please enter a query." }, Cmd.none )
      else
        ( { model | errorMessage = Nothing }, searchRecipes model.query model.chosenDietLabel model.chosenHealthLabel )
    SearchRecipesResult (Ok hits) ->
      ( { model | hits = Just hits }, Cmd.none )
    SearchRecipesResult (Err error) ->
      ( { model | errorMessage = Just "We're having problems while retrieving the recipes, please try again later!" }, Cmd.none )
    Logout ->
      ( model, Auth.clear )


subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none