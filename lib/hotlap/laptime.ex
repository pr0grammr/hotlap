defmodule Hotlap.Laptime do

  use Hotlap.Types

  defstruct minutes: 0, seconds: 0, milliseconds: 0, status: nil


  @moduledoc """
  Hotlap.Laptime struct
  represents a laptime
  """

  @doc """
  Creates a Hotlap.Laptime struct from the following laptime format: minutes:seconds:milliseconds

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
  Creates a Hotlap.Laptime struct from milliseconds

  ## Examples
      iex> Hotlap.Laptime.create 104005
      {:ok, %Hotlap.Laptime{minutes: 1, seconds: 44, milliseconds: 5}}
  """
  @spec create(laptime_milliseconds) :: {:ok, Hotlap.Laptime}
  def create(laptime_milliseconds) when is_number(laptime_milliseconds) do
    laptime = Hotlap.LaptimeConverter.from_milliseconds(laptime_milliseconds)
    laptime = %Hotlap.Laptime{minutes: laptime[:minutes], seconds: laptime[:seconds], milliseconds: laptime[:milliseconds]}
    {:ok, laptime}
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
