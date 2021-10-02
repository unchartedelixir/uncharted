defmodule Uncharted.StackedColumnChart.Section do
  @moduledoc """
  A struct representing column section-level configurations.
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
