defmodule Uncharted.ScatterPlot.Dataset do
  @moduledoc """
  Struct representing a dataset for a basic scatter plot.
  """
  defstruct [:axes, :data]

  @type t() :: %__MODULE__{
          axes: Uncharted.Axes.XYAxes.t(),
          data: list(Uncharted.BaseDatum.t())
        }
end
