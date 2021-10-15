defmodule Uncharted.BaseDatum do
  @moduledoc """
  Exposes a struct representing a basic data point
  """
  defstruct [:name, :fill_color, :fill_opacity, :values]

  @type t() :: %__MODULE__{
          name: String.t(),
          fill_color: atom(),
          fill_opacity: float(),
          values: list(number)
        }
end
