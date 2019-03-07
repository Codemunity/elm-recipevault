module App.Types exposing (..)

import Navigation exposing (Location)
import Routing.Types exposing (..)
import Login.Types
import SignUp.Types
import RecipeSearch.Types
import FavoriteRecipe.Types
import Auth.Types exposing (..)

type alias Model =
    { loginModel : Login.Types.Model
    , signUpModel : SignUp.Types.Model
    , recipeSearchModel : RecipeSearch.Types.Model
    , favoriteRecipeModel : FavoriteRecipe.Types.Model
    , currentRoute : Route
    , flags: Flags
    }
    
type alias Flags =
    { auth: Maybe Auth
    }

type Msg
    = LoginMsg Login.Types.Msg
    | SignUpMsg SignUp.Types.Msg
    | RecipeSearchMsg RecipeSearch.Types.Msg
    | FavoriteRecipeMsg FavoriteRecipe.Types.Msg
    | OnLocationChange Location
    | Logout
    | AuthCleared