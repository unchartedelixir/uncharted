defmodule Uncharted.ProgressChart.Dataset do
  @moduledoc """
  Exposes a struct representing a data set that drives
  a Uncharted Progress Chart.
  """
  defstruct [
    :background_stroke_color,
    :label,
    :secondary_label,
    :to_value,
    :current_value,
    :percentage_text_fill_color,
    :percentage_fill_color,
    :label_fill_color,
    progress_shape: :round,
    donut_width: 5
  ]

  @typep color :: atom()
  @type t() :: %__MODULE__{
          background_stroke_color: color(),
          label: String.t() | nil,
          secondary_label: String.t() | nil,
          to_value: number(),
          current_value: number(),
          percentage_text_fill_color: color(),
          percentage_fill_color: color(),
          label_fill_color: color(),
          progress_shape: :round | :butt | :square,
          donut_width: number()
        }
end
