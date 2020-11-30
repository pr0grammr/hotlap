defmodule Hotlap.LaptimeConverter do

  use Hotlap.Types

  @moduledoc """
  converter to convert a Hotlap.Laptime struct to milliseconds
  and to convert milliseconds to a Hotlap.Laptime struct
  """

  @doc """
  Converts a laptime struct into miliseconds
  """
  @spec to_milliseconds(time) :: integer
  def to_milliseconds(laptime) do
    Enum.sum([laptime.minutes * 60 * 1000, laptime.seconds * 1000, laptime.milliseconds])
  end


  @doc """
  converts milliseconds to a laptime map
  returned map can be used for Hotlap.Laptime and Hotlap.Delta
  """
  @spec from_milliseconds(time) :: Hotlap.Laptime
  def from_milliseconds(laptime_milliseconds) do

    # check if laptime is negative
    status = case laptime_milliseconds < 0 do
      true -> :behind
      false -> :ahead
    end

    # remove sign from number to avoid wrong laptimes
    laptime_milliseconds = case laptime_milliseconds < 0 do
      true -> Integer.to_string(laptime_milliseconds) |> String.slice(1..-1) |> String.to_integer
      false -> laptime_milliseconds
    end

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
    %{minutes: minutes, seconds: seconds, milliseconds: milliseconds, status: status}
  end
end
