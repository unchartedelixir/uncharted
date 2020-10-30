defmodule Uncharted.BaseDatum do
  @moduledoc """
  Exposes a struct representing a basic data point
  """
  defstruct [:name, :fill_color, :values, :emphasize]

  @type t() :: %__MODULE__{
          name: String.t(),
          fill_color: atom(),
          values: list(number),
          emphasize: boolean()
        }
end
