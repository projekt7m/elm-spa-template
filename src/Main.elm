module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (..)
import Json.Decode as Decode exposing (Value)
import Url exposing (Url)


type Model
    = NotFound


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init () url navKey =
    ( NotFound, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest


view : Model -> Document Msg
view model =
    case model of
        NotFound ->
            { title = "not found", body = [ p [] [ text "Hallo Welt!" ] ] }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
