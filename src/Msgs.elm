module Msgs exposing (..)

import Http
import Players.Players exposing (Player, PlayerId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Material

type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
    | Mdl (Material.Msg Msg)
