defmodule Hotlap.DeltaTest do
  use ExUnit.Case
  doctest Hotlap.Delta

  test "string_repr_milliseconds" do
    delta_behind = %Hotlap.Delta{milliseconds: 332, status: :behind}
    assert "#{delta_behind}" == "+0.332"

    delta_ahead = %Hotlap.Delta{milliseconds: 332, status: :ahead}
    assert "#{delta_ahead}" == "-0.332"
  end

  test "string_repr_milliseconds_seconds" do
    delta_behind = %Hotlap.Delta{seconds: 2, milliseconds: 188, status: :behind}
    assert "#{delta_behind}" == "+2.188"

    delta_ahead = %Hotlap.Delta{seconds: 2, milliseconds: 188, status: :ahead}
    assert "#{delta_ahead}" == "-2.188"
  end

  test "string_repr_milliseconds_seconds_minutes" do
    delta_behind = %Hotlap.Delta{minutes: 1, seconds: 5, milliseconds: 287, status: :behind}
    assert "#{delta_behind}" == "+01:05.287"

    delta_ahead = %Hotlap.Delta{minutes: 1, seconds: 5, milliseconds: 287, status: :ahead}
    assert "#{delta_ahead}" == "-01:05.287"
  end

end
