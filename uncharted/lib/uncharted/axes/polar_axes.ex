defmodule Uncharted.Axes.PolarAxes do
  @moduledoc """
  A struct for representing a polar coordinate system's axes
  """

  defstruct [:r, :t, show_gridlines: true]

  @type t() :: %__MODULE__{
          r: Uncharted.Axes.MagnitudeAxis.t(),
          t: Uncharted.Axes.MagnitudeAxis.t(),
          show_gridlines: boolean()
        }
end
