defmodule Hotlap.Delta do

  use Hotlap.Types
  use Hotlap.Prototype

end

defimpl String.Chars, for: Hotlap.Delta do
  def to_string(delta) do
    "test"
  end
end
