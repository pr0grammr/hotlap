defmodule HotlapTest do
  use ExUnit.Case
  doctest Hotlap

  test "test_compare" do
    target_lap = %Hotlap.Laptime{minutes: 1, seconds: 11, milliseconds: 332}
    current_lap = %Hotlap.Laptime{minutes: 1, seconds: 11, milliseconds: 554}
    assert Hotlap.compare(target_lap, current_lap) == %Hotlap.Delta{minutes: 0, seconds: 0, milliseconds: 222, status: :behind}

    target_lap = %Hotlap.Laptime{minutes: 1, seconds: 28, milliseconds: 78}
    current_lap = %Hotlap.Laptime{minutes: 1, seconds: 29, milliseconds: 131}
    assert Hotlap.compare(target_lap, current_lap) == %Hotlap.Delta{minutes: 0, seconds: 1, milliseconds: 53, status: :behind}

    target_lap = %Hotlap.Laptime{minutes: 1, seconds: 29, milliseconds: 78}
    current_lap = %Hotlap.Laptime{minutes: 1, seconds: 29, milliseconds: 12}
    assert Hotlap.compare(target_lap, current_lap) == %Hotlap.Delta{minutes: 0, seconds: 0, milliseconds: 66, status: :ahead}
  end
end
