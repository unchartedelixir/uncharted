defmodule Uncharted.HorizontalFunnelChart.Dataset do
  @moduledoc """
  Struct representing a dataset for a Uncharted basic bar chart.
  """
  defstruct [:axes, :data, direction: :down, sections: []]

  @type t() :: %__MODULE__{
          axes: Uncharted.Axes.BaseAxes.t(),
          direction: :up | :down,
          sections: list(Uncharted.Section.t()),
          data: list(Uncharted.BaseDatum.t())
        }
end
