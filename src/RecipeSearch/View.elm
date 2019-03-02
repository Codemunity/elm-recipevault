module RecipeSearch.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import RecipeSearch.Types exposing (..)
import Maybe
  
searchInputStyles : List (String, String ) 
searchInputStyles =
  [ ("width", "60%")
  , ("border-radius", "10px")
  , ("padding", "10px")
  , ("font-size", "1.4rem")
  ]
  
selectContainerStyles =
  [ ("display", "inline-block")
  , ("width", "30%")
  , ("padding", "2% 5%")
  ]

searchButtonStyles =
  [ ("padding", "15px 45px")
  , ("font-size", "1.2rem")
  , ("border", "0")
  , ("background-color", "MediumPurple")
  , ("color", "white")
  , ("border-radius", "10px")
  , ("cursor", "pointer")
  ]

view : Model -> Html Msg
view model =
  div []
    [ div [] [ button [ onClick Logout ] [ text "Logout" ] ]
    , div [ style [ ("color", "red") ] ] [ text (Maybe.withDefault "" model.errorMessage) ]
    , div [] [ input [ style searchInputStyles, type_ "text", placeholder "What do you fancy?", onInput NewQuery, value model.query ] [] ]
    , div [ style selectContainerStyles ] [ multipleSelect OnDietSelected model.chosenDietLabel model.allDietLabels ]
    , div [ style selectContainerStyles ] [ multipleSelect OnHealthSelected model.chosenHealthLabel model.allHealthLabels ]
    , div [] [ button [ style searchButtonStyles, onClick SearchRecipes ] [ text "Search" ] ]
    , hitsView model.hits
    ]
    
hitsView : Maybe Hits -> Html Msg
hitsView maybeHits =
  case maybeHits of
    Just hits ->
      div []
        [ text ((toString hits.count) ++ " recipes found.")
        , div [] (List.map hitView hits.hits)
        ]
    Nothing ->
      div [] []
      
hitView : Hit -> Html Msg
hitView hit =
  let
    recipe =
      hit.recipe
    servings =
      toString recipe.servings
    calories =
      toString recipe.calories
  in
    div []
      [ div [] [ text recipe.title ]
      , img [ src recipe.image ] []
      , a [ href recipe.url ] []
      , div [] [ text ("From: " ++ recipe.source) ]
      , div [] [ text (servings ++ " servings.") ]
      , div [] [ text (calories ++ " calories.") ]
      , div []
        [ div [] [ text "Ingredients:" ]
        , ul [] ( List.map (\i -> li [] [ text i ] ) recipe.ingredients )
        ]
      , labelsView recipe.dietLabels "diet-labels"
      , labelsView recipe.healthLabels "health-labels"
      ]

labelsView : List String -> String -> Html Msg
labelsView labels className =
  div [ class className ]
    ( List.map (\l -> div [ class "label" ] [ text l ] ) labels )
  
multipleSelect : (String -> Msg) -> Maybe String -> List String -> Html Msg
multipleSelect msg chosenElement allElements =
  div [] (List.map (singleSelect msg chosenElement) allElements)
  
singleSelect : (String -> Msg) -> Maybe String -> String -> Html Msg
singleSelect msg chosenElement element =
  let
    backgroundColor =
      if element == (Maybe.withDefault "" chosenElement) then
        "salmon"
      else
        "ghostwhite"
  in
    div [ style [ ("background-color", backgroundColor)
                , ("margin", "5px 0")
                , ("padding", "5px 0")
                , ("border-radius", "10px")
                ]
        , onClick (msg element) 
        ] 
        [ text element ]