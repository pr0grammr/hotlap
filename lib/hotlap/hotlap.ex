defmodule Hotlap do

  use Hotlap.Types
  @moduledoc """
  Hotlap main module
  """

  @doc """
  compares 2 laptime structs and returns a Hotlap.Delta struct

  ## Examples
      iex> target_laptime = Hotlap.Laptime.create("01:22.344")
      iex> current_laptime = Hotlap.Laptime.create("01:22.600")
      iex> delta = Hotlap.compare(target_laptime, current_laptime)
      %Hotlap.Delta{minutes: 0, seconds: 0, milliseconds: 256, status: :behind}
  """
  @spec compare(laptime, laptime) :: Hotlap.Delta
  def compare(target_laptime, current_laptime) do
    delta = Hotlap.LaptimeConverter.from_milliseconds(Hotlap.LaptimeConverter.to_milliseconds(target_laptime) - Hotlap.LaptimeConverter.to_milliseconds(current_laptime))
    %Hotlap.Delta{minutes: delta.minutes, seconds: delta.seconds, milliseconds: delta.milliseconds, status: delta.status}
  end

end
