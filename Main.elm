module Main exposing (..)

import Html exposing (Html, beginnerProgram, div, button, h1, h2, span, text)
import Html.Attributes exposing (class, style, attribute, title)
import Html.Events exposing (onClick)


main =
    beginnerProgram
        { model = []
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
    | Undo


update msg model =
    case msg of
        IncUs playing ->
            let
                head =
                    List.head model |> Maybe.withDefault (Model 0 0 0)

                plusMinus =
                    if playing then
                        head.plusMinus + 1
                    else
                        head.plusMinus
            in
                { head | us = head.us + 1, plusMinus = plusMinus } :: model

        IncThem playing ->
            let
                head =
                    List.head model |> Maybe.withDefault (Model 0 0 0)

                plusMinus =
                    if playing then
                        head.plusMinus - 1
                    else
                        head.plusMinus
            in
                { head | them = head.them + 1, plusMinus = plusMinus } :: model

        Undo ->
            case model of
                [] -> []
                _ :: history -> history


view : List Model -> Html Msg
view model =
    let
        head =
            List.head model |> Maybe.withDefault (Model 0 0 0)

        plusMinusColor =
            if head.plusMinus > 0 then
                [ style [ ( "color", "green" ) ] ]
            else if head.plusMinus < 0 then
                [ style [ ( "color", "red" ) ] ]
            else
                []
    in
        div [ class "container-fluid" ]
            [ div [ class "row" ]
                [ div [ class "col-xs-4" ] [ h1 [] [ text <| toString head.us ] ]
                , div [ class "col-xs-4" ] [ h2 plusMinusColor [ text <| toString head.plusMinus ] ]
                , div [ class "col-xs-4" ] [ h1 [] [ text <| toString head.them ] ]
                ]
            , div [ class "row container-fluid" ]
                [ button [ class "btn btn-default", onClick <| IncUs False, ariaLabel "Score without you", title "+" ]
                    [ span [ class "glyphicon glyphicon-menu-left", ariaHidden ] [] ]
                , button [ class "btn btn-default", onClick <| IncUs True, ariaLabel "Score with you", title "+ You" ]
                    [ span [ class "glyphicon glyphicon-triangle-left", ariaHidden ] [] ]
                , button [ class "btn btn-default", onClick Undo, ariaLabel "Undo", title "Undo" ]
                    [ span [ class "glyphicon glyphicon-repeat icon-flipped", ariaHidden ] [] ]
                , button [ class "btn btn-default", onClick <| IncThem True, ariaLabel "Score against you", title "- You" ]
                    [ span [ class "glyphicon glyphicon-triangle-right", ariaHidden ] [] ]
                , button [ class "btn btn-default", onClick <| IncThem False, ariaLabel "Score against your team", title "-" ]
                    [ span [ class "glyphicon glyphicon-menu-right" ] [] ]
                ]
            ]


ariaLabel : String -> Html.Attribute msg
ariaLabel =
    attribute "aria-label"


ariaHidden : Html.Attribute msg
ariaHidden =
    attribute "aria-hidden" "true"
