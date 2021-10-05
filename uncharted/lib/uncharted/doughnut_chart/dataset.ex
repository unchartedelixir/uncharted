defmodule Uncharted.DoughnutChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a basic doughnut chart.
  """
  defstruct [:data]

  @type t() :: %__MODULE__{
          data: Uncharted.DoughnutChart.Dataset.t()
        }
end
