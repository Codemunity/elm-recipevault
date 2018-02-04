port module Auth.State exposing (..)

import Auth.Types exposing (..)

-- Ports

port setAuth : Auth -> Cmd msg
port clearAuth : () -> Cmd msg
port authCleared : (() -> msg) -> Sub msg

set : Auth -> Cmd msg
set auth =
    setAuth auth

clear : Cmd msg
clear =
  clearAuth()

cleared : msg -> Sub msg
cleared msg =
  authCleared (\() -> msg)
