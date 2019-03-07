module RecipeSearch.State exposing (init, update, subscriptions)

import Recipe.Types exposing (..)
import RecipeSearch.Types exposing (..)
import RecipeSearch.Rest exposing (..)
import FavoriteRecipe.Types exposing (FavoriteRecipe)
import Auth.State as Auth
import Auth.Types exposing (..)

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

update : Auth -> Msg -> Model -> ( Model, Cmd Msg )
update auth msg model =
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
    CreateFavoriteRecipe recipe ->
      let
        favoriteRecipe =
          recipeToFavorite recipe
      in
        ( model, createFavoriteRecipe "https://recipevault-miguelcodemunity.c9users.io/api" auth favoriteRecipe )
    CreateFavoriteRecipeResult (Ok _) ->
      ( model, Cmd.none )
    CreateFavoriteRecipeResult (Err error) ->
      ( { model | errorMessage = Just "We're having problems while marking the recipes as a favorite, please try again later!" }, Cmd.none )

recipeToFavorite : Recipe -> FavoriteRecipe
recipeToFavorite recipe =
  { label = recipe.title
  , image = recipe.image
  , url = recipe.url
  , calories = recipe.calories
  , source = recipe.source
  }

subscriptions : Model -> Sub Msg
subscriptions = \_ -> Sub.none