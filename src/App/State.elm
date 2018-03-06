module App.State exposing (..)

import App.Types exposing (..)
import Routing.Types exposing (..)
import Navigation exposing (Location)
import Login.State
import SignUp.State
import RecipeSearch.State
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
    authCmd =
      case (initialRoute, flags.auth) of
        (LoginRoute, Just _) ->
          Navigation.modifyUrl "#recipe-search"
        (SignUpRoute, Just _) ->
          Navigation.modifyUrl "#recipe-search"
        (RecipeSearchRoute, Nothing) ->
          Navigation.modifyUrl "#login"
        _ ->
          Cmd.none
  in
    ( { loginModel = loginModel
      , signUpModel = signUpModel
      , recipeSearchModel = recipeSearchModel
      , currentRoute = initialRoute
      , flags = flags
      }
    , Cmd.batch [ Cmd.map LoginMsg loginCmd
                , Cmd.map SignUpMsg signUpCmd
                , Cmd.map RecipeSearchMsg recipeSearchCmd
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
      let
        ( recipeSearchModel, recipeSearchCmd ) =
          RecipeSearch.State.update recipeSearchMsg model.recipeSearchModel
      in
        ( { model | recipeSearchModel = recipeSearchModel }, Cmd.map RecipeSearchMsg recipeSearchCmd )
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
    , Auth.cleared AuthCleared
    ]
