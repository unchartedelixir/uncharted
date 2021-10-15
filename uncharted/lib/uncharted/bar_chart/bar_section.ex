defmodule Uncharted.BarChart.BarSection do
  @moduledoc """
  A struct representing bar section-level display properties.
  """

  defstruct [
    :offset,
    :label,
    :bar_width,
    :bar_value,
    :fill_color
  ]

  @type t() :: %__MODULE__{
          label: String.t(),
          bar_width: float(),
          bar_value: float(),
          fill_color: atom()
        }
end
