module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Json.Decode as Decode exposing (Value)
import Route exposing (Route)
import Session exposing (Session)
import Url exposing (Url)
import WebpackAsset exposing (assetUrl)


type Model
    = NotFound Session
    | Home Session
    | Page1 Session
    | Page2 Session


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init () url navKey =
    let
        route =
            Route.fromUrl url

        initialModel =
            Home (Session.fromNavKey navKey)
    in
    changeRouteTo route initialModel


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            ( model, Cmd.none )

                        Just _ ->
                            ( model, Nav.pushUrl (Session.navKey (toSession model)) (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest


toSession : Model -> Session
toSession page =
    case page of
        NotFound session ->
            session

        Home session ->
            session

        Page1 session ->
            session

        Page2 session ->
            session


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just Route.Home ->
            ( Home session, Cmd.none )

        Just Route.Page1 ->
            ( Page1 session, Cmd.none )

        Just Route.Page2 ->
            ( Page2 session, Cmd.none )


navbar : Html msg
navbar =
    nav [ class "navbar navbar-expand-lg navbar-light bg-light" ]
        [ div [ class "container-fluid" ]
            [ a [ class "navbar-brand", Route.href Route.Home ] [ img [ style "width" "30px", src (assetUrl "./Elm_logo.png"), alt "Navbar" ] [] ]
            , button [ class "navbar-toggler", type_ "button", attribute "data-bs-toggle" "collapse", attribute "data-bs-target" "#navbarSupportedContent", ariaControls "navbarSupportedContent", ariaExpanded "false", ariaLabel "Toggle navigation" ] [ span [ class "navbar-toggler-icon" ] [] ]
            , div [ class "collapse navbar-collapse", id "navbarSupportedContent" ]
                [ ul [ class "navbar-nav me-auto mb-2 mb-lg-0" ]
                    [ li [ class "nav-item" ] [ a [ class "nav-link", Route.href Route.Home ] [ text "home" ] ]
                    , li [ class "nav-item" ] [ a [ class "nav-link", Route.href Route.Page1 ] [ text "page 1" ] ]
                    , li [ class "nav-item" ] [ a [ class "nav-link", Route.href Route.Page2 ] [ text "page 2" ] ]
                    ]
                ]
            ]
        ]


view : Model -> Document Msg
view model =
    case model of
        NotFound _ ->
            { title = "not found"
            , body =
                [ navbar
                , p [ class "h1" ] [ text "Page not found" ]
                , br [] []
                , img [ src (assetUrl "./Elm_logo.png"), alt "" ] []
                ]
            }

        Home _ ->
            { title = "home"
            , body =
                [ navbar
                , h1 [] [ text "Home" ]
                , br [] []
                , p [] [ text "You are on the home page" ]
                ]
            }

        Page1 _ ->
            { title = "page 1"
            , body =
                [ navbar
                , h1 [] [ text "Page 1" ]
                , br [] []
                , p [] [ text "You are on page 1" ]
                ]
            }

        Page2 _ ->
            { title = "page 2"
            , body =
                [ navbar
                , h1 [] [ text "Page 2" ]
                , br [] []
                , p [] [ text "You are on page 2" ]
                ]
            }


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
