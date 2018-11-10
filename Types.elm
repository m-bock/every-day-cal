module Types exposing (..)


type Model
    = Playing { numberChecked : DayOfYear }
    | Done


type alias Day =
    Int


type alias DayOfYear =
    Int


type Msg
    = Next


type alias Month =
    Int


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
