module App.State exposing (..)

import App.Types exposing (..)
import Routing.Types exposing (..)
import Navigation exposing (Location)
import Login.State
import SignUp.State

init : Location -> ( Model, Cmd Msg )
init location =
    let
        initialRoute =
            parseLocation location
        ( loginModel, loginCmd ) =
          Login.State.init
        ( signUpModel, signUpCmd ) =
          SignUp.State.init
    in
        ( { loginModel = loginModel
          , signUpModel = signUpModel
          , currentRoute = initialRoute
          }
        , Cmd.batch [ Cmd.map LoginMsg loginCmd
                    , Cmd.map SignUpMsg signUpCmd
                    ]
        )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LoginMsg loginMsg ->
      let
          ( loginModel, loginCmd ) =
            Login.State.update loginMsg model.loginModel
      in
          ( { model | loginModel = loginModel }, Cmd.map LoginMsg loginCmd )
    SignUpMsg signUpMsg ->
      let
          ( signUpModel, signUpCmd ) =
            SignUp.State.update signUpMsg model.signUpModel
      in
          ( { model | signUpModel = signUpModel }, Cmd.map SignUpMsg signUpCmd )
    OnLocationChange location ->
          init location

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map LoginMsg (Login.State.subscriptions model.loginModel)
    , Sub.map SignUpMsg (SignUp.State.subscriptions model.signUpModel)
    ]
