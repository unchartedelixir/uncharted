defmodule Uncharted.Axes.MagnitudeAxis do
  @moduledoc """
  Exposes a struct representing configuration for an axis that has values that increase in a particular direction
  """
  defstruct [:min, :max, :step, :label, :units, grid_lines: &__MODULE__.default_grid_lines_fun/2]
  @type min :: number()
  @type max :: number()
  @type num_steps :: integer()
  @type units :: atom()

  @typedoc """
  A function that takes a tuple with a minimum and maximum value that
  represents the min and max of a grid axis and a step value. This function
  is used to determine the spacial offsets of the labels on the axis and the
  gridlines of the chart.
  """
  @type grid_lines_func :: ({min, max}, num_steps() -> list(float()))
  @type t() :: %__MODULE__{
          min: number(),
          max: number(),
          units: units(),
          step: integer(),
          label: String.t() | nil,
          grid_lines: grid_lines_func
        }

  @doc """
  The default function used to determine spacial offsets of labels
  along an axis, as well as `grid_lines` going across a chart.

  If you do not specify a different `grid_lines_func` function
  when you create a `Uncharted.Axes.MagnitudeAxis` struct, this
  implementation will be provided used.
  """
  @spec default_grid_lines_fun({min, max}, num_steps()) :: list(float())
  def default_grid_lines_fun({min, max}, num_steps) do
    step_size = (max - min) / (num_steps * 1.0)

    Enum.map(0..num_steps, fn step -> step * step_size end)
  end
end
