module Types exposing (..)


type Model
    = Playing { numberChecked : Int }
    | Done


type Msg
    = Next


type alias Calendar =
    { months : List CalendarMonth
    }


type alias CalendarMonth =
    { days : List CalendarDay
    }


type alias CalendarDay =
    { checked : Bool
    , dayOfYear : Int
    }
