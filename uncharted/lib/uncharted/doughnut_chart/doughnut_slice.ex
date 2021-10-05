defmodule Uncharted.DoughnutChart.DoughnutSlice do
  @moduledoc """
  A struct representing doughnut chart slice display properties.
  """

  defstruct [:label, :percentage, :fill_color]

  @type t() :: %__MODULE__{
          label: String.t(),
          percentage: float(),
          fill_color: atom()
        }
end
