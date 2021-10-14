defmodule Uncharted.FunnelChart.Bar do
  @moduledoc """
  A struct representing bar-level display properties.
  """

  defstruct [
    :height,
    :offset,
    :label,
    :bar_height,
    :bar_offset,
    :full_bar_value,
    :full_bar_percentage,
    :sections
  ]

  @type t() :: %__MODULE__{
          height: float(),
          offset: float(),
          label: String.t(),
          bar_height: float(),
          bar_offset: float(),
          full_bar_value: float(),
          full_bar_percentage: float(),
          sections: list(Uncharted.FunnelChart.BarSection.t())
        }
end
