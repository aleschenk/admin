module Players.Players exposing (Model, model, PlayerId, Player)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player) }


model : Model
model =
    { players = RemoteData.Loading
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }
