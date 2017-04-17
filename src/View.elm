module View exposing (..)

import Html exposing (Html, div, text, h1)
import Html.Attributes exposing (style)
import Models exposing (Model)
import Players.Players as Players exposing (PlayerId)
import Players.List
import Msgs exposing (Msg)
import Home.List
import Players.Edit
import Players.List
import RemoteData
-- Material
import Material
import Material.Layout as Layout
import Material.Color as Color
-- import Material.Button as Button exposing (..)
import Material.Options as Options exposing (css, when)
import Material.Icon as Icon
import Material.Scheme

view : Model -> Html Msg
view model =
    div []
        [ mainLayout model ]
{--}
tabs : List ( String, String, Model -> Html Msg )
tabs =
    [ ( "Players", "players", .players >> Players.List.view >> Html.map Msg )
    ]

tabTitles : List (Html a)
tabTitles =
    List.map (\( x, _, _ ) -> text x) tabs
--}

mainLayout : Models.Model -> Html Msgs.Msg
mainLayout model =
    Material.Scheme.topWithScheme Color.Teal Color.LightGreen <|
        Layout.render Msgs.Mdl
            model.mdl
            [ Layout.fixedHeader ]
            { header =
                [ h1 [ style [ ( "padding", "1rem" ) ] ]
                    [ text model.title ]
                ]
            , drawer = []
            , tabs = ( [ text "About", text "Team" ], [ Color.background (Color.color Color.Teal Color.S400) ] )
            , main = [ page model ]
            }

page : Models.Model -> Html Msgs.Msg
page model =
    case model.route of
        Models.Home ->
            Home.List.view

        Models.PlayersRoute ->
            Players.List.view model.players.players

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.NotFoundRoute ->
            notFoundView


playerEditPage : Models.Model -> PlayerId -> Html Msgs.Msg
playerEditPage model playerId =
    case model.players.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        Players.Edit.view player

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
