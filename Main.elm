module Main exposing (..)

import Html exposing (beginnerProgram, div, button, h1, h2, span, text)
import Html.Attributes exposing (class, style, attribute, title)
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
                [ style [ ( "color", "green" ) ] ]
            else if model.plusMinus < 0 then
                [ style [ ( "color", "red" ) ] ]
            else
                []
    in
        div [ class "container-fluid" ]
            [ div [ class "row" ]
                [ div [ class "col-xs-4" ] [ h1 [] [ text <| toString model.us ] ]
                , div [ class "col-xs-4" ] [ h2 plusMinusColor [ text <| toString model.plusMinus ] ]
                , div [ class "col-xs-4" ] [ h1 [] [ text <| toString model.them ] ]
                ]
            , div [ class "row container-fluid" ]
                [ button [ class "btn btn-default", onClick <| IncUs False, ariaLabel "Score without you", title "+" ]
                    [ span [ class "glyphicon glyphicon-menu-up", ariaHidden ] [] ]
                , button [ class "btn btn-default", onClick <| IncUs True, ariaLabel "Score with you", title "+ You" ]
                    [ span [ class "glyphicon glyphicon-triangle-top", ariaHidden ] [] ]
                , button [ class "btn btn-default", onClick Reset, ariaLabel "Reset", title "Reset" ]
                    [ span [ class "glyphicon glyphicon-repeat", ariaHidden ] [] ]
                , button [ class "btn btn-default", onClick <| IncThem True, ariaLabel "Score against you", title "- You" ]
                    [ span [ class "glyphicon glyphicon-triangle-bottom", ariaHidden ] [] ]
                , button [ class "btn btn-default", onClick <| IncThem False, ariaLabel "Score against your team", title "-" ]
                    [ span [ class "glyphicon glyphicon-menu-down" ] [] ]
                ]
            ]


ariaLabel : String -> Html.Attribute msg
ariaLabel =
    attribute "aria-label"


ariaHidden : Html.Attribute msg
ariaHidden =
    attribute "aria-hidden" "true"
