defmodule UnchartedPhoenix.LiveLineComponentTest do
  alias Uncharted.BaseChart
  alias Uncharted.Component
  alias Uncharted.Axes.{MagnitudeAxis, XYAxes}
  alias Uncharted.LineChart.Dataset
  alias UnchartedPhoenix.LiveLineComponent
  import Phoenix.LiveViewTest
  use ExUnit.Case
  @endpoint Endpoint
  @axes %XYAxes{
    x: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2
    },
    y: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2
    }
  }
  @configured_axes %XYAxes{
    x: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2,
      line_color: "green",
      line_width: 7
    },
    y: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2
    }
  }
  @base_chart %BaseChart{title: "this title", dataset: %Dataset{axes: @axes, data: []}}
  @configured_chart %BaseChart{
    title: "this title",
    dataset: %Dataset{axes: @configured_axes, data: []}
  }

  describe "LiveLineComponent" do
    test "renders" do
      assert render_component(LiveLineComponent, chart: @base_chart, id: Component.id(@base_chart)) =~
               ~s(data-testid="lc-live-line-component")
    end

    test "renders the chart's title" do
      assert render_component(LiveLineComponent, chart: @base_chart, id: Component.id(@base_chart)) =~
               @base_chart.title
    end

    test "renders grid lines according to configuration" do
      assert render_component(LiveLineComponent, chart: @configured_chart) =~
               "stroke=\"green\""

      assert render_component(LiveLineComponent, chart: @configured_chart) =~
               "stroke-width=\"7px\""
    end
  end

  def grid_line_fun({min, max}, _step) do
    Enum.take_every(min..max, 500)
  end
end
