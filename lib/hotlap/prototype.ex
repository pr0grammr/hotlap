defmodule Hotlap.Prototype do
  @moduledoc """
  prototype for Hotlap.Laptime and Hotlap.Delta structs
  """

  @doc """
  macro for using in modules
  """
  defmacro __using__(_opts) do
    quote do
      defstruct minutes: 0, seconds: 0, milliseconds: 0
    end
  end
end
