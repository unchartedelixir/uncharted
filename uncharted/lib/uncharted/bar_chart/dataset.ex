defmodule Uncharted.BarChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a Uncharted basic bar chart.
  """
  defstruct [:axes, :data, sections: []]

  @type t() :: %__MODULE__{
          axes: Uncharted.Axes.BaseAxes.t(),
          sections: list(Uncharted.Section.t()),
          data: list(Uncharted.BaseDatum.t())
        }
end
