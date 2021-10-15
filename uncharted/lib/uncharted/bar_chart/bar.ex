defmodule Uncharted.BarChart.Bar do
  @moduledoc """
  A struct representing bar-level display properties.
  """

  defstruct [
    :height,
    :offset,
    :label,
    :bar_height,
    :bar_offset,
    :sections
  ]

  @type t() :: %__MODULE__{
          height: float(),
          offset: float(),
          label: String.t(),
          bar_height: float(),
          bar_offset: float(),
          sections: list(Uncharted.BarChart.BarSection.t())
        }
end
