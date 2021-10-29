defmodule Uncharted.HorizontalFunnelChart.Bar do
  @moduledoc """
  A struct representing bar-level display properties.
  """

  defstruct [
    :width,
    :offset,
    :label,
    :full_bar_value,
    :full_bar_percentage,
    :sections
  ]

  @type t() :: %__MODULE__{
          width: float(),
          offset: float(),
          label: String.t(),
          full_bar_value: float(),
          full_bar_percentage: float(),
          sections: list(Uncharted.FunnelChart.BarSection.t())
        }
end
