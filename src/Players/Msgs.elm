module Players.Msgs exposing (Msg)

import Http
import Players.Players exposing (Player)
import RemoteData exposing (WebData)

type Msg
    = OnFetchPlayers (WebData (List Player))
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
