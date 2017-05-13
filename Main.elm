module Main exposing (..)

import Html exposing (beginnerProgram, div, button, h1, h2, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)


main =
    beginnerProgram
        { model = Model 0 0 0
        , update = update
        , view = view
        }


type alias Model =
    { us : Int
    , them : Int
    , plusMinus : Int
    }


type Msg
    = IncUs Bool
    | IncThem Bool
    | Reset


update msg model =
    case msg of
        IncUs playing ->
            let
                plusMinus =
                    if playing then
                        model.plusMinus + 1
                    else
                        model.plusMinus
            in
                { model | us = model.us + 1, plusMinus = plusMinus }

        IncThem playing ->
            let
                plusMinus =
                    if playing then
                        model.plusMinus - 1
                    else
                        model.plusMinus
            in
                { model | them = model.them + 1, plusMinus = plusMinus }

        Reset ->
            Model 0 0 0


view model =
    let
        plusMinusColor =
            if model.plusMinus > 0 then
                "green"
            else if model.plusMinus < 0 then
                "red"
            else
                "black"
    in
        div [ class "container-fluid" ]
            [ div [ class "row" ]
                [ div [ class "col-xs-4" ] [ h1 [ style [ ( "text-align", "center" ) ] ] [ text <| toString model.us ] ]
                , div [ class "col-xs-4 align-bottom" ] [ h2 [ style [ ( "text-align", "center" ), ( "color", plusMinusColor ) ] ] [ text <| toString model.plusMinus ] ]
                , div [ class "col-xs-4" ] [ h1 [ style [ ( "text-align", "center" ) ] ] [ text <| toString model.them ] ]
                ]
            , div [ class "row" ]
                [ button [ class "col-xs-3 btn btn-default", onClick <| IncUs False ] [ text "+" ]
                , button [ class "col-xs-2 btn btn-default", onClick <| IncUs True ] [ text "+ You" ]
                , button [ class "col-xs-2 btn btn-default", onClick Reset ] [ text "Reset" ]
                , button [ class "col-xs-2 btn btn-default", onClick <| IncThem True ] [ text "- You" ]
                , button [ class "col-xs-3 btn btn-default", onClick <| IncThem False ] [ text "-" ]
                ]
            ]
