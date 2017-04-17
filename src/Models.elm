module Models exposing (..)

import Players.Players as Players
import Material


type alias Model =
    { mdl : Material.Model
    , title : String
    , players : Players.Model
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { mdl = Material.model
    , title = "Users"
    , players = Players.model
    , route = route
    }


type Route
    = Home
    | PlayersRoute
    | PlayerRoute Players.PlayerId
    | NotFoundRoute
