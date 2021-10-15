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
    :sections
  ]

  @type t() :: %__MODULE__{
          width: float(),
          offset: float(),
          label: String.t(),
          bar_width: float(),
          bar_offset: float(),
          sections: list(Uncharted.ColumnChart.ColumnSection.t())
        }
end
