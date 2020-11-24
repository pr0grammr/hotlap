defmodule Hotlap.LaptimeConverterTest do
  use ExUnit.Case
  doctest Hotlap.LaptimeConverter

  test "convert to milliseconds" do
    assert Hotlap.LaptimeConverter.to_milliseconds(%Hotlap.Laptime{minutes: 1, seconds: 22, milliseconds: 330}) == 82330
    assert Hotlap.LaptimeConverter.to_milliseconds(%Hotlap.Laptime{minutes: 1, seconds: 55, milliseconds: 113}) == 115113
  end
end
