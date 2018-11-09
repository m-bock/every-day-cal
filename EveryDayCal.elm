module EveryDayCal exposing (..)

import Css as Css exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (css)


-- TYPE


type alias Model =
    Int


type Msg
    = NoOp



-- CONSTANT


constants :
    { daysPerYear : Int
    , monthsLengths : List Int
    , nMonths : Int
    , maxDays : Int
    }
constants =
    { daysPerYear =
        365
    , monthsLengths =
        [ 31, 28, 31, 30, 31, 30, 31, 30, 31, 30, 31, 30 ]
    , nMonths = 1
    , maxDays = 31
    }



--colors : { bg : Color, fg : Color }


colors =
    { bg = rgb 34 24 67
    , day = rgb 14 74 37
    , empty = rgb 56 14 89
    }



-- UTILS


empties : List Int
empties =
    List.map (\x -> constants.maxDays - x) constants.monthsLengths



-- UPDATE


initModel : Model
initModel =
    0


update : Msg -> Model -> Model
update msg model =
    model



-- VIEW


viewYear : Model -> Html Msg
viewYear model =
    let
        styleContainer =
            [ property "display" "inline-grid"
            , property "grid-auto-flow" "column"
            , property "grid-template-columns" ("repeat(" ++ toString constants.nMonths ++ ", 1fr)")
            , property "grid-template-rows" ("repeat(" ++ toString constants.maxDays ++ ", 1fr)")
            , property "grid-gap" "1px"
            , backgroundColor colors.bg
            ]

        styleItem =
            [ Css.width (px 20)
            , Css.height (px 20)

            --, backgroundColor colors.fg
            ]
    in
    div [ css styleContainer ]
        (List.repeat 365 (div [ css styleItem ] []))


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Every Day Cal"
            , div [] [ viewYear model ]
            ]
        ]



-- MAIN


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
