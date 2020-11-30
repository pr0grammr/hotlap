defmodule Hotlap.Delta do

  use Hotlap.Types

  defstruct minutes: 0, seconds: 0, milliseconds: 0

end

defimpl String.Chars, for: Hotlap.Delta do
  def to_string(delta) do
    "test"
  end
end
