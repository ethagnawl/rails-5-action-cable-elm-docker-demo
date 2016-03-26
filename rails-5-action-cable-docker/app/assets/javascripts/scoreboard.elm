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

type alias Score = {
  initials: String,
  score: Int
}

type alias Model =
  {
    scores : List Score
  }

init =
  Model [{initials = "PRD", score = 0}]

port incomingScore : Signal Score

newScore =
  Signal.map ScoreReceived incomingScore

type Action =
    ScoreReceived Score
  | Noop

update action model =
  case action of
    ScoreReceived newScore ->
      let
        scores = newScore
                  |> flip (::) model.scores
                  -- |> List.sort
                  -- |> List.reverse
                  -- |> List.take 10
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
    inputs = [newScore]
  }

main = app.html
