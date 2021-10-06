defmodule Uncharted.DoughnutChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a basic doughnut chart.
  """
  defstruct [
    :data,
    :center_value,
    :center_value_fill_color,
    :label,
    :label_fill_color,
    :secondary_label
  ]

  @typep color :: atom()
  @type t() :: %__MODULE__{
          data: Uncharted.DoughnutChart.Dataset.t(),
          center_value: number(),
          center_value_fill_color: color(),
          label: String.t() | nil,
          label_fill_color: color(),
          secondary_label: String.t() | nil
        }
end
