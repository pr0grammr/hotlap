defmodule Hotlap.Types do
  defmacro __using__(_opts) do
    quote do
      @type laptime :: Hotlap.Laptime
      @type laptime_string :: String.t()
      @type laptime_milliseconds :: integer
    end
  end
end
