defmodule Uncharted.ColumnChart.Column do
  @moduledoc """
  A struct representing column-level display properties.
  """

  defstruct [
    :width,
    :offset,
    :label,
    :bar_width,
    :bar_offset,
    :column_height,
    :column_value,
    :fill_color
  ]

  @type t() :: %__MODULE__{
          width: float(),
          offset: float(),
          label: String.t(),
          bar_width: float(),
          bar_offset: float(),
          column_height: float(),
          column_value: float(),
          fill_color: atom()
        }
end
