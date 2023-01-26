defmodule Amnesia.Eraser do
  defstruct [:text, :plan]

  def new(text, steps \\ 3) do
    %__MODULE__{text: text, plan: generate_plan(text, steps)}
  end

  def erase(%__MODULE__{text: text, plan: [step | steps]} = eraser) do
    chars_with_index = indexed_chars(text)
    new_text =
      (for {index, str} <- chars_with_index, do: replace({index, str}, step))
      |> Enum.join
    %{eraser | text: new_text, plan: steps}
  end

  def show(eraser) do
    eraser.text
  end

  defp indexed_chars(text) do
    Enum.zip(1..String.length(text), String.graphemes(text))
  end

  defp generate_plan(text, steps) do
    1..String.length(text) |> Enum.shuffle |> Enum.chunk_every(ceil(String.length(text) / steps) )
  end

  defp replace({index, str}, step) do
    cond do
      str == " " -> " "
      index in step -> "_"
      true -> str
    end
  end
end
