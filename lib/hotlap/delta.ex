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
      iex> delta = Hotlap.compare(%Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 855}, %Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 606})
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
      iex> delta = Hotlap.compare(%Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 855}, %Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 606})
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
        } -> "#{pre_symbol}0.#{convert(milliseconds, 3)}"
      %Hotlap.Delta{
        minutes: 0,
        seconds: seconds,
        milliseconds: milliseconds
        } -> "#{pre_symbol}#{seconds}.#{convert(milliseconds, 3)}"
      %Hotlap.Delta{
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds
        } -> "#{pre_symbol}#{convert(minutes, 2)}:#{convert(seconds, 2)}.#{convert(milliseconds, 3)}"
    end
  end

  def convert(number, leading_zeros) do
    number |> Integer.to_string |> String.pad_leading(leading_zeros, "0")
  end
end
