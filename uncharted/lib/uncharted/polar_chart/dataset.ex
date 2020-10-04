defmodule Uncharted.PolarChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a basic polar chart.
  """
  defstruct [:axes, :data]

  @type t() :: %__MODULE__{
          axes: Uncharted.Axes.PolarAxes.t(),
          data: list(Uncharted.BaseDatum.t())
        }
end
