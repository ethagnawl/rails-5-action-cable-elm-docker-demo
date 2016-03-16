module Scoreboard where

import Effects exposing (Effects, Never)
import Html.Attributes exposing (..)
import Html exposing (Html, Attribute, text, div, header)
import Signal exposing (Address, Signal)
import StartApp
import Task

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks

type alias Model =
  {
    scores : List Int
  }

init =
  Model [0]

port encryptionCompleted : Signal Int

incomingScore =
  Signal.map ScoreReceived encryptionCompleted

type Action =
    ScoreReceived Int
  | Noop

update action model =
  case action of
    ScoreReceived encrypted ->
      let
        scores = encrypted
                  |> flip (::) model.scores
                  |> List.sort
                  |> List.reverse
                  |> List.take 10
      in
        ({ model | scores = scores }
          , Effects.none
        )
    Noop ->
      ( model, Effects.none )

view address model =
  let
    stringifiedScores = List.map toString model.scores
    scores = div
               []
               (List.map
                 (\ score -> div [] [text score])
                 stringifiedScores)
    header' = header [] [text "High Scores"]
  in
     div
       []
       [
         header',
         scores
       ]

app =
  StartApp.start {
    init = (init, Effects.none),
    view = view,
    update = update,
    inputs = [incomingScore]
  }

main = app.html
