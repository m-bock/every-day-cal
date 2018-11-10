module EveryDayCal exposing (..)

import Color as Color exposing (..)
import Css as Css exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Types exposing (..)


-- UTIL


chunkBySizes : List Int -> List a -> List (List a)
chunkBySizes ns xs =
    case ns of
        n :: nRest ->
            List.take n xs :: chunkBySizes nRest (List.drop n xs)

        [] ->
            []


getCalendar : Int -> Calendar
getCalendar dayOfYear =
    let
        max =
            List.sum constants.monthsLengths

        days =
            List.range 0 constants.daysPerYear
                |> List.map
                    (\index -> { dayOfYear = index, checked = index < dayOfYear })
    in
    { months =
        days
            |> chunkBySizes constants.monthsLengths
            |> List.map (\days -> { days = days })
    }


getDayOfYear : Int -> Int -> Int
getDayOfYear month day =
    List.take month constants.monthsLengths
        |> List.sum
        |> (+) day


toCssColor : Color.Color -> Css.Color
toCssColor color =
    color
        |> Color.toRgb
        |> (\{ red, green, blue, alpha } -> Css.rgba red green blue alpha)



-- CONSTANT


constants :
    { daysPerYear : Int
    , monthsLengths : List Int
    , maxDays : Int
    }
constants =
    { daysPerYear = 365
    , monthsLengths = [ 31, 28, 31, 30, 31, 30, 31, 30, 31, 30, 31, 30 ]
    , maxDays = 31
    }


copy :
    { done : String
    , title : String
    }
copy =
    { done = "done"
    , title = "Every Day Cal"
    }


colors :
    { bg : Color.Color
    , dayChecked : Color.Color
    , dayUnchecked : Color.Color
    }
colors =
    { bg = lightGray
    , dayChecked = red
    , dayUnchecked = gray
    }



-- UPDATE


initModel : Model
initModel =
    Playing { numberChecked = 0 }


update : Msg -> Model -> Model
update msg model =
    case ( msg, model ) of
        ( Next, Playing { numberChecked } ) ->
            if numberChecked < (constants.daysPerYear - 1) then
                Playing { numberChecked = numberChecked + 1 }
            else
                Done

        _ ->
            model



-- VIEW


viewCalendarDay : CalendarDay -> Html Msg
viewCalendarDay { checked, dayOfYear } =
    let
        length =
            20

        style =
            [ backgroundColor <|
                toCssColor
                    (if checked then
                        colors.dayChecked
                     else
                        colors.dayUnchecked
                    )
            , Css.width (px length)
            , Css.height (px length)
            ]
    in
    div [ onClick Next, css style ] []


viewCalendarMonth : CalendarMonth -> List (Html Msg)
viewCalendarMonth { days } =
    List.map viewCalendarDay days


addEmptyDays : List (Html Msg) -> List (Html Msg)
addEmptyDays days =
    let
        n =
            constants.maxDays - List.length days
    in
    days ++ List.repeat n (div [] [])


viewCalendar : Calendar -> Html Msg
viewCalendar { months } =
    let
        repeat1fr n =
            "repeat(" ++ toString n ++ ", 1fr)"

        nMonths =
            List.length constants.monthsLengths

        style =
            [ property "display" "inline-grid"
            , property "grid-auto-flow" "column"
            , property "grid-template-columns" (repeat1fr nMonths)
            , property "grid-template-rows" (repeat1fr constants.maxDays)
            , property "grid-gap" "1px"
            , backgroundColor (toCssColor colors.bg)
            ]
    in
    div [ css style ]
        (List.concatMap (viewCalendarMonth >> addEmptyDays) months)


viewDone : Html Msg
viewDone =
    div [] [ text copy.done ]


viewApp : Model -> Html Msg
viewApp model =
    let
        style =
            [ textAlign center ]
    in
    case model of
        Playing { numberChecked } ->
            div [ css style ]
                [ viewCalendar (getCalendar numberChecked) ]

        Done ->
            viewDone


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text copy.title ]
        , viewApp model
        ]



-- MAIN


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
