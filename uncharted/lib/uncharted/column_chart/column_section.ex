defmodule Uncharted.ColumnChart.ColumnSection do
  @moduledoc """
  A struct representing column section-level display properties.
  """

  defstruct [
    :offset,
    :label,
    :column_height,
    :column_value,
    :fill_color
  ]

  @type t() :: %__MODULE__{
          label: String.t(),
          column_height: float(),
          column_value: float(),
          fill_color: atom()
        }
end
