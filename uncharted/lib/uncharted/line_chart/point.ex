defmodule Uncharted.LineChart.Point do
  @moduledoc """
  A struct representing a Point on an x, y coordinate chart
  """

  defstruct [:label, :fill_color, :x_offset, :y_offset, :x_value, :y_value]

  @type t :: %__MODULE__{
          label: String.t(),
          fill_color: atom(),
          x_offset: float(),
          y_offset: float(),
          x_value: float(),
          y_value: float()
        }
end
