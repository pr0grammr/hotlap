defmodule Hotlap.LaptimeTest do
  use ExUnit.Case
  doctest Hotlap.Laptime

  test "create_laptime_from_string" do
    assert Hotlap.Laptime.create("01:18.855") == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 855}}
    assert Hotlap.Laptime.create("1:18.22") == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 22}}
    assert Hotlap.Laptime.create("1:06.2") == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 6, milliseconds: 2}}
    assert Hotlap.Laptime.create("1:02.033") == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 2, milliseconds: 33}}
    assert Hotlap.Laptime.create("1:44.005") == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 44, milliseconds: 5}}
  end

  test "create_laptime_from_milliseconds" do
    assert Hotlap.Laptime.create(78855) == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 855}}
    assert Hotlap.Laptime.create(78022) == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 18, milliseconds: 22}}
    assert Hotlap.Laptime.create(66002) == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 6, milliseconds: 2}}
    assert Hotlap.Laptime.create(62033) == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 2, milliseconds: 33}}
    assert Hotlap.Laptime.create(104005) == {:ok, %Hotlap.Laptime{minutes: 1, seconds: 44, milliseconds: 5}}
  end

  test "string_repr" do
    assert "#{%Hotlap.Laptime{minutes: 1, seconds: 33, milliseconds: 202}}" == "01:33.202"
    assert "#{%Hotlap.Laptime{minutes: 1, seconds: 1, milliseconds: 2}}" == "01:01.002"
    assert "#{%Hotlap.Laptime{minutes: 2, seconds: 2, milliseconds: 880}}" == "02:02.880"
    assert "#{%Hotlap.Laptime{minutes: 1, seconds: 0, milliseconds: 12}}" == "01:00.012"
    assert "#{%Hotlap.Laptime{minutes: 1, seconds: 54, milliseconds: 22}}" == "01:54.022"
  end

end
