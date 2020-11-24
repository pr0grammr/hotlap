defmodule HotlapTest do
  use ExUnit.Case
  doctest Hotlap.Laptime

  test "creates_laptime" do
    assert Hotlap.Laptime.create("01:18.855") == %Hotlap.Laptime{minutes: 1, seconds: 18, miliseconds: 855}
    assert Hotlap.Laptime.create("1:18.22") == %Hotlap.Laptime{minutes: 1, seconds: 18, miliseconds: 22}
    assert Hotlap.Laptime.create("1:06.2") == %Hotlap.Laptime{minutes: 1, seconds: 6, miliseconds: 2}
    assert Hotlap.Laptime.create("1:02.033") == %Hotlap.Laptime{minutes: 1, seconds: 2, miliseconds: 33}
    assert Hotlap.Laptime.create("1:44.005") == %Hotlap.Laptime{minutes: 1, seconds: 44, miliseconds: 5}
  end

  test "string_repr" do
    assert "#{%Hotlap.Laptime{minutes: 1, seconds: 33, miliseconds: 202}}" == "01:33.202"
    assert "#{%Hotlap.Laptime{minutes: 1, seconds: 1, miliseconds: 2}}" == "01:01.002"
    assert "#{%Hotlap.Laptime{minutes: 2, seconds: 2, miliseconds: 880}}" == "02:02.880"
    assert "#{%Hotlap.Laptime{minutes: 1, seconds: 0, miliseconds: 12}}" == "01:00.012"
    assert "#{%Hotlap.Laptime{minutes: 1, seconds: 54, miliseconds: 22}}" == "01:54.022"
  end
end
