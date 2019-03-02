module RecipeSearch.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import FavoriteRecipe.Types exposing (..)
import Maybe

deleteButtonStyles =
  [ ("padding", "15px 45px")
  , ("font-size", "1.2rem")
  , ("border", "0")
  , ("background-color", "tomato")
  , ("color", "white")
  , ("border-radius", "10px")
  , ("cursor", "pointer")
  ]

view : Model -> Html Msg
view model =
  div []
    , div [ style [ ("color", "red") ] ] [ text (Maybe.withDefault "" model.errorMessage) ]
    , favoriteRecipesView model.favoriteRecipes
    ]

favoriteRecipesView : Maybe (List FavoriteRecipe) -> Html Msg
favoriteRecipesView maybeFavoriteRecipes =
  case maybeHits of
    Just favoriteRecipes ->
      div []
        [ text ("You've got " ++ (toString favoriteRecipes.count) ++ " favorite recipes.")
        , div [] (List.map favoriteRecipeView favoriteRecipes)
        ]
    Nothing ->
      div [] []

favoriteRecipeView : FavoriteRecipe -> Html Msg
favoriteRecipeView recipe =
  let
    calories =
      toString recipe.calories
  in
    div []
      [ div [] [ text recipe.label ]
      , img [ src recipe.image ] []
      , a [ href recipe.url ] []
      , div [] [ text ("From: " ++ recipe.source) ]
      , div [] [ text (calories ++ " calories.") ]
      , div [] [ button [ style deleteButtonStyles, onClick (DeleteFavoriteRecipe recipe) ] [ text "Unfavorite" ] ]
      ]