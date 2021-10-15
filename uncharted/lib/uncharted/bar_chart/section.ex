defmodule Uncharted.BarChart.Section do
  @moduledoc """
  A struct representing bar section-level configurations.
  """

  defstruct [
    :fill_color,
    :label,
    :index
  ]

  @type t() :: %__MODULE__{
          fill_color: atom(),
          label: String.t(),
          index: integer()
        }
end
