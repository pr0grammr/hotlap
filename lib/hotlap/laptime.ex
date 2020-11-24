defmodule Hotlap.Laptime do
  @moduledoc """
  Documentation for Hotlap.
  """

  defstruct minutes: 0, seconds: 0, milliseconds: 0

  @typedoc """
  Hotlap.Laptime struct
  """
  @type laptime :: Hotlap.Laptime

  @typedoc """
  laptime string representation (e.g.: "01:22.344")
  """
  @type laptime_string :: String.t()


  @doc """
  Creates a %Hotlap.Laptime struct from the following laptime format: minutes:seconds:milliseconds

  ## Examples
      iex> Hotlap.Laptime.create "01:18.855"
      {:ok, %Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 855}}
  """
  @spec create(laptime_string) :: {atom, Hotlap.Laptime}
  def create(laptime_string) when is_binary(laptime_string) do
    case Regex.named_captures(~r/(?<minutes>\d+):(?<seconds>\d+)\.(?<milliseconds>\d+)/, laptime_string) do
      nil -> {:error, "Given laptime is not a valid format"}
      %{
        "minutes" => minutes,
        "seconds" => seconds,
        "milliseconds" => milliseconds
        } -> {:ok, %Hotlap.Laptime{minutes: String.to_integer(minutes), seconds: String.to_integer(seconds), milliseconds: String.to_integer(milliseconds)}}
    end
  end

  @doc """
  compares 2 laptime structs and returns a Hotlap.Delta struct
  """
  @spec compare(laptime, laptime) :: Hotlap.Delta
  def compare(target_laptime, current_laptime) do
    Hotlap.LaptimeConverter.to_milliseconds(target_laptime) - Hotlap.LaptimeConverter.to_milliseconds(current_laptime)
  end

end


defimpl String.Chars, for: Hotlap.Laptime do

  @doc """
  String representation of a laptime
  """
  def to_string(laptime) do
    minutes = laptime.minutes
    |> Integer.to_string
    |> String.pad_leading(2, "0")

    seconds = laptime.seconds
    |> Integer.to_string
    |> String.pad_leading(2, "0")

    milliseconds = laptime.milliseconds
    |> Integer.to_string
    |> String.pad_leading(3, "0")

    "#{minutes}:#{seconds}.#{milliseconds}"
  end
end
