module Models exposing (..)

import RemoteData exposing (WebData)
import Material


type alias Model =
    { mdl : Material.Model
    , title : String
    , players : WebData (List Player)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { mdl = Material.model
    , title = "Users"
    , players = RemoteData.Loading
    , route = route
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


type Route
    = 
    Home
    | PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute