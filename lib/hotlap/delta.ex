defmodule Hotlap.Delta do

  use Hotlap.Types

  defstruct minutes: 0, seconds: 0, milliseconds: 0, status: nil


  @moduledoc """
  Hotlap.Delta struct
  represents a delta between two structs of Hotlap.Laptime
  """


  @doc """
  checks true if delta time is ahead the target time

  ## Examples
      iex> {:ok, target_laptime} = Hotlap.Laptime.create("01:18.855")
      iex> {:ok, current_laptime} = Hotlap.Laptime.create("01:18.606")
      iex> delta = Hotlap.compare(target_laptime, current_laptime)
      iex> Hotlap.Delta.is_ahead?(delta)
      true
  """
  @spec is_ahead?(delta) :: bool
  def is_ahead?(delta) do
    delta.status == :ahead
  end


  @doc """
  checks true if delta time is behind the target time

  ## Examples
      iex> {:ok, target_laptime} = Hotlap.Laptime.create("01:18.855")
      iex> {:ok, current_laptime} = Hotlap.Laptime.create("01:18.606")
      iex> delta = Hotlap.compare(target_laptime, current_laptime)
      iex> Hotlap.Delta.is_behind?(delta)
      false
  """
  @spec is_behind?(delta) :: bool
  def is_behind?(delta) do
    delta.status == :behind
  end

end

defimpl String.Chars, for: Hotlap.Delta do

  @doc """
  string representation for a delta time
  """
  def to_string(delta) do
    pre_symbol = case Hotlap.Delta.is_ahead?(delta) do
      true -> "-"
      false -> "+"
    end

    case delta do
      %Hotlap.Delta{
        minutes: 0,
        seconds: 0,
        milliseconds: milliseconds
        } -> "#{pre_symbol}0.#{Hotlap.LaptimeConverter.convert_number(milliseconds, 3)}"
      %Hotlap.Delta{
        minutes: 0,
        seconds: seconds,
        milliseconds: milliseconds
        } -> "#{pre_symbol}#{seconds}.#{Hotlap.LaptimeConverter.convert_number(milliseconds, 3)}"
      %Hotlap.Delta{
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds
        } -> "#{pre_symbol}#{Hotlap.LaptimeConverter.convert_number(minutes, 2)}:#{Hotlap.LaptimeConverter.convert_number(seconds, 2)}.#{Hotlap.LaptimeConverter.convert_number(milliseconds, 3)}"
    end
  end

end
