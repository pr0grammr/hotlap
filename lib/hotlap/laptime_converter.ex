defmodule Hotlap.LaptimeConverter do

  use Hotlap.Types

  @moduledoc """
  converter to convert a Hotlap.Laptime struct to milliseconds
  and to convert milliseconds to a Hotlap.Laptime struct
  """

  @doc """
  Converts a laptime struct into miliseconds

  ## Examples
      iex> {:ok, laptime} = Hotlap.Laptime.create("01:32.331")
      iex> Hotlap.LaptimeConverter.to_milliseconds(laptime)
      92331
  """
  @spec to_milliseconds(time) :: integer
  def to_milliseconds(laptime) do
    Enum.sum([laptime.minutes * 60 * 1000, laptime.seconds * 1000, laptime.milliseconds])
  end


  @doc """
  converts milliseconds to a laptime map
  returned map can be used for Hotlap.Laptime and Hotlap.Delta

  ## Examples
      iex> Hotlap.LaptimeConverter.from_milliseconds(92331)
      %{minutes: 1, seconds: 32, milliseconds: 331, status: :ahead}
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

    # create laptime map
    %{minutes: minutes, seconds: seconds, milliseconds: milliseconds, status: status}
  end


  @doc """
  fills up a number with leading zeros
  """
  @spec convert_number(integer, integer) :: String.t()
  def convert_number(number, leading_zeros) do
    number |> Integer.to_string |> String.pad_leading(leading_zeros, "0")
  end

end
