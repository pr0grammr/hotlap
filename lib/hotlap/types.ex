defmodule Hotlap.Types do
  @moduledoc """
  all available types
  """

  @doc """
  macro for using in modules
  """
  defmacro __using__(_opts) do
    quote do
      @type laptime :: Hotlap.Laptime
      @type laptime_string :: String.t()
      @type laptime_milliseconds :: integer
    end
  end
end
