defmodule Uncharted.DonutChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a basic donut chart.
  """
  defstruct [
    :data,
    :data_name_label,
    :data_value_label,
    :center_value,
    :center_value_fill_color,
    :label,
    :label_fill_color,
    :secondary_label
  ]

  @typep color :: atom()
  @type t() :: %__MODULE__{
          data: list(Uncharted.BaseDatum.t()),
          data_name_label: String.t(),
          data_value_label: String.t(),
          center_value: number(),
          center_value_fill_color: color(),
          label: String.t() | nil,
          label_fill_color: color(),
          secondary_label: String.t() | nil
        }
end

defimpl Uncharted.Dataset, for: Uncharted.DonutChart.Dataset do
  alias Uncharted.DonutChart.Dataset

  def data_name_label(%Dataset{data_name_label: data_name_label}), do: data_name_label
  def data_value_label(%Dataset{data_value_label: data_value_label}), do: data_value_label
end
