defmodule Uncharted.HorizontalFunnelChart.BarSection do
  @moduledoc """
  A struct representing bar section-level display properties.
  """

  defstruct [
    :label,
    :bar_height,
    :bar_value,
    :x_points,
    :y_points,
    :fill_color
  ]

  @type t() :: %__MODULE__{
          label: String.t(),
          bar_height: float(),
          bar_value: float(),
          fill_color: atom(),
          x_points: list(float()),
          y_points: list(float())
        }
end
