defmodule Uncharted.PolarChart.Point do
  @moduledoc """
  A struct representing a Point on a polar r, t coordinate chart
  """

  defstruct [:label, :r, :t]

  @type t :: %__MODULE__{
          label: String.t(),
          r: Float.t(),
          t: Float.t()
        }
end
