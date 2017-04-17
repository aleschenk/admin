module Update exposing (..)

import Commands exposing (savePlayerCmd)
import Models exposing (Model)
import Players.Players as Players exposing (Player)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData
import Material

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            let
                players = model.players
                newPlayers = { players | players = response }
            in
                ( { model | players = newPlayers}, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer = { player | level = player.level + howMuch }
            in  
                ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            let 
                newPlayersModel = updatePlayer model.players player
            in 
                ( {model | players = newPlayersModel }, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )

        Msgs.Mdl msg_ ->
            Material.update Msgs.Mdl msg_ model

updatePlayer : Players.Model -> Player -> Players.Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
