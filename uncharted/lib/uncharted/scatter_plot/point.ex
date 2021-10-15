defmodule Uncharted.ScatterPlot.Point do
  @moduledoc """
  A struct representing a Point on an x, y coordinate chart
  """

  defstruct [
    :label,
    :fill_color,
    :x_offset,
    :y_offset,
    :x_value,
    :y_value,
    radius: 6,
    fill_opacity: 0.6
  ]

  @type t :: %__MODULE__{
          label: String.t(),
          fill_color: atom(),
          fill_opacity: float(),
          x_offset: float(),
          y_offset: float(),
          x_value: float(),
          y_value: float(),
          radius: float()
        }
end
