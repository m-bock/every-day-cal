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
            [ property "display" "grid"
            , property "grid-auto-flow" "column"
            , property "grid-template-columns" ("repeat(" ++ toString constants.nMonths ++ ", 1fr)")
            , property "grid-template-rows" ("repeat(" ++ toString constants.maxDays ++ ", 1fr)")
            ]

        styleItem =
            []
    in
    div [ css styleContainer ]
        [ div [ css styleItem ] [ text "X" ]
        , div [ css styleItem ] [ text "Y" ]
        , div [ css styleItem ] [ text "Z" ]
        , div [ css styleItem ] [ text "X" ]
        , div [ css styleItem ] [ text "Y" ]
        , div [ css styleItem ] [ text "Z" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Every Day Cal"
            , viewYear model
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
