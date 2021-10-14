defmodule Uncharted.FunnelChart.BarSection do
  @moduledoc """
  A struct representing bar section-level display properties.
  """

  defstruct [
    :offset,
    :lower_offset,
    :offset_end,
    :lower_offset_end,
    :label,
    :bar_width,
    :bar_value,
    :fill_color
  ]

  @type t() :: %__MODULE__{
          label: String.t(),
          bar_width: float(),
          bar_value: float(),
          fill_color: atom(),
          offset: float(),
          lower_offset: float(),
          offset_end: float(),
          lower_offset_end: float()
        }
end
