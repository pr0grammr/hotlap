defmodule Hotlap.LaptimeConverter do
  @moduledoc """
  converter to convert a Hotlap.Laptime struct to milliseconds
  and to convert milliseconds to a Hotlap.Laptime struct
  """

  @typedoc """
  Hotlap.Laptime struct
  """
  @type laptime :: Hotlap.Laptime

  @typedoc """
  Laptime in milliseconds
  """
  @type laptime_milliseconds :: integer


  @doc """
  Converts a laptime struct into miliseconds
  """
  @spec to_milliseconds(laptime) :: integer
  def to_milliseconds(laptime) do
    Enum.sum([laptime.minutes * 60 * 1000, laptime.seconds * 1000, laptime.milliseconds])
  end


  @doc """
  converts laptime in milliseconds to a Hotlap.Laptime struct
  """
  @spec from_milliseconds(laptime_milliseconds) :: Hotlap.Laptime
  def from_milliseconds(laptime_milliseconds) do
    minutes = 0
    seconds = 0
    milliseconds = 0

    minutes_calculated = laptime_milliseconds / 1000 / 60
    seconds_calculated = laptime_milliseconds / 1000

    # calculate minutes from milliseconds
    minutes = case minutes_calculated > 0 do
      true -> trunc(minutes_calculated)
      false -> 0
    end

    # calculate seconds from milliseconds
    seconds = case seconds_calculated > 0 do
      true -> trunc(seconds_calculated) - (minutes * 60)
      false -> 0
    end

    # calculate remaining milliseconds
    milliseconds = laptime_milliseconds - ((minutes * 60 * 1000) + (seconds * 1000))

    # create Laptime struct
    %{minutes: minutes, seconds: seconds, milliseconds: milliseconds}
  end
end
