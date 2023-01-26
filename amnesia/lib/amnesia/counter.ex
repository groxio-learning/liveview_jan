defmodule Amnesia.Counter do
  defstruct count: 0

  def new do
    %__MODULE__{}
  end

  def increment(%__MODULE__{count: count}) do
    %__MODULE__{count: count + 1}
  end

  def decrement(%__MODULE__{count: count}) do
    %__MODULE__{count: count - 1}
  end

  def reset(_) do
    %__MODULE__{count: 0}
  end

  def count(%__MODULE__{count: count}) do
    count
  end
end
