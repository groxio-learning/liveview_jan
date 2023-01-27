# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Amnesia.Repo.insert!(%Amnesia.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Amnesia.Library

create_prompt(%{
  text: "Did you try turning it off and on again?",
  title: "ITCrowd",
  steps: 3
})

create_prompt(%{
  text:
    "Fear is the path to the dark side. Fear leads to anger. Anger leads to hate. Hate leads to suffering.",
  title: "Master Yoda",
  steps: 3
})

create_prompt(%{
  text: "I'm your Huckleberry, thats just my game!",
  title: "Let's play!",
  steps: 3
})

create_prompt(%{
  text: "es ist noch kein meister vom himmel gefallen",
  title: "Work Hard",
  steps: 3
})

create_prompt(%{
  text: "Man kann nicht den Fünfer und das Weggli haben",
  title: "No Cake for you!",
  steps: 3
})

create_prompt(%{
  text: "Dadinho é o caralho, meu nome agora é Zé Pequeno porra!",
  title: "Cidade de Deus",
  steps: 3
})
