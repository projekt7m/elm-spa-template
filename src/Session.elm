module Session exposing (Session, fromNavKey, navKey)

import Browser.Navigation as Nav



-- TYPES


type Session
    = Session Nav.Key


navKey : Session -> Nav.Key
navKey (Session session) =
    session


fromNavKey : Nav.Key -> Session
fromNavKey nKey =
    Session nKey
