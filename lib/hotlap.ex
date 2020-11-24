defmodule Hotlap.Laptime do
  @moduledoc """
  Documentation for Hotlap.
  """
  defstruct minutes: 0, seconds: 0, miliseconds: 0

  @doc """
  Creates a %Hotlap.Laptime struct from the following laptime format: minutes:seconds:miliseconds

  ## Examples
      iex> Hotlap.Laptime.create "01:18.855"
      %Hotlap.Laptime{minutes: 1, seconds: 18, miliseconds: 855}
  """
  def create(laptime_string) do
    case Regex.named_captures(~r/(?<minutes>\d+):(?<seconds>\d+)\.(?<miliseconds>\d+)/, laptime_string) do
      nil -> {:error, "Given laptime is not a valid format"}
      %{
        "minutes" => minutes,
        "seconds" => seconds,
        "miliseconds" => miliseconds
        } -> %Hotlap.Laptime{minutes: String.to_integer(minutes), seconds: String.to_integer(seconds), miliseconds: String.to_integer(miliseconds)}
    end
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

    miliseconds = laptime.miliseconds
    |> Integer.to_string
    |> String.pad_leading(3, "0")

    "#{minutes}:#{seconds}.#{miliseconds}"
  end
end
