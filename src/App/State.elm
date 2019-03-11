module App.State exposing (..)

import App.Types exposing (..)
import Routing.Types exposing (..)
import Navigation exposing (Location)
import Login.State
import SignUp.State
import RecipeSearch.State
import FavoriteRecipe.State
import Auth.State as Auth

init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
  let
    initialRoute =
        parseLocation location
    ( loginModel, loginCmd ) =
      Login.State.init
    ( signUpModel, signUpCmd ) =
      SignUp.State.init
    ( recipeSearchModel, recipeSearchCmd ) =
      RecipeSearch.State.init
    ( favoriteRecipeModel, favoriteRecipeCmd ) =
      FavoriteRecipe.State.init flags.auth
    authCmd =
      case (initialRoute, flags.auth) of
        (LoginRoute, Just _) ->
          Navigation.modifyUrl "#recipe-search"
        (SignUpRoute, Just _) ->
          Navigation.modifyUrl "#recipe-search"
        (RecipeSearchRoute, Nothing) ->
          Navigation.modifyUrl "#login"
        (FavoriteRecipeRoute, Nothing) ->
          Navigation.modifyUrl "#login"
        _ ->
          Cmd.none
  in
    ( { loginModel = loginModel
      , signUpModel = signUpModel
      , recipeSearchModel = recipeSearchModel
      , favoriteRecipeModel = favoriteRecipeModel
      , currentRoute = initialRoute
      , flags = flags
      }
    , Cmd.batch [ Cmd.map LoginMsg loginCmd
                , Cmd.map SignUpMsg signUpCmd
                , Cmd.map RecipeSearchMsg recipeSearchCmd
                , Cmd.map FavoriteRecipeMsg favoriteRecipeCmd
                , authCmd
                ]
    )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LoginMsg loginMsg ->
      let
        ( loginModel, loginCmd, auth ) =
          Login.State.update loginMsg model.loginModel
        oldFlags = 
          model.flags
        newFlags =
          { oldFlags | auth = auth }
      in
        ( { model | loginModel = loginModel, flags = newFlags }, Cmd.map LoginMsg loginCmd )
    SignUpMsg signUpMsg ->
      let
        ( signUpModel, signUpCmd, auth ) =
          SignUp.State.update signUpMsg model.signUpModel
        oldFlags = 
          model.flags
        newFlags =
          { oldFlags | auth = auth }
      in
        ( { model | signUpModel = signUpModel, flags = newFlags }, Cmd.map SignUpMsg signUpCmd )
    RecipeSearchMsg recipeSearchMsg ->
      case model.flags.auth of
        Just auth ->
          let
            ( recipeSearchModel, recipeSearchCmd ) =
              RecipeSearch.State.update auth recipeSearchMsg model.recipeSearchModel
          in
            ( { model | recipeSearchModel = recipeSearchModel }, Cmd.map RecipeSearchMsg recipeSearchCmd )
        Nothing ->
          ( model, Navigation.modifyUrl "#login" )
    FavoriteRecipeMsg favoriteRecipeMsg ->
      let
        ( favoriteRecipeModel, favoriteRecipeCmd ) =
          FavoriteRecipe.State.update favoriteRecipeMsg model.favoriteRecipeModel
      in
        ( { model | favoriteRecipeModel = favoriteRecipeModel }, Cmd.map FavoriteRecipeMsg favoriteRecipeCmd )
    OnLocationChange location ->
      init model.flags location
    Logout ->
      ( model, Auth.clear )
    AuthCleared ->
      let
          oldFlags =
            model.flags
          newFlags =
            { oldFlags | auth = Nothing }
      in
        ( { model | flags = newFlags }, Navigation.modifyUrl "#login")

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map LoginMsg (Login.State.subscriptions model.loginModel)
    , Sub.map SignUpMsg (SignUp.State.subscriptions model.signUpModel)
    , Sub.map RecipeSearchMsg (RecipeSearch.State.subscriptions model.recipeSearchModel)
    , Sub.map FavoriteRecipeMsg (FavoriteRecipe.State.subscriptions model.favoriteRecipeModel)
    , Auth.cleared AuthCleared
    ]
