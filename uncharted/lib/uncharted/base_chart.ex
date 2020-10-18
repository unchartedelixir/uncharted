defmodule Uncharted.BaseChart do
  @moduledoc """
  This is the base chart implementation of the Chart protocol, and should be sufficient for most simple charting needs.
  Specific charts implement further protocols in the respective `base_chart_impl.ex` file within the chart type's
  folder.
  """
  alias __MODULE__

  defstruct [:title, :colors, :component_id, :dataset, :width, :height show_table: false]

  @typep color_name() :: atom()

  @type t() :: %__MODULE__{
          title: String.t(),
          colors: %{color_name() => String.t() | Uncharted.Gradient.t()},
          dataset: Uncharted.dataset(),
          show_table: boolean(),
          width: number(),
          height: number()
        }

  defimpl Uncharted.Chart, for: __MODULE__ do
    alias Uncharted.{BaseChart, Gradient}
    def title(%BaseChart{title: nil}), do: ""
    def title(%BaseChart{title: title}), do: title

    def colors(%BaseChart{colors: nil}), do: %{}
    def colors(%BaseChart{colors: colors}), do: colors

    def gradient_colors(%BaseChart{colors: nil}), do: %{}

    def gradient_colors(%BaseChart{colors: colors}) do
      colors
      |> Enum.filter(fn {_key, value} ->
        case value do
          %Gradient{} -> true
          _ -> false
        end
      end)
      |> Map.new()
    end
  end
end
