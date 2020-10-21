defmodule UnchartedPhoenix.LiveLineComponentTest do
  alias Uncharted.BaseChart
  alias Uncharted.Axes.{MagnitudeAxis, XYAxes}
  alias Uncharted.LineChart.Dataset
  import UnchartedPhoenix.TestRenderer
  use ExUnit.Case

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
      assert render_chart(@base_chart) =~ ~s(data-testid="lc-live-line-component")
    end

    test "renders the chart's title" do
      assert render_chart(@base_chart) =~ @base_chart.title
    end

    test "renders grid lines according to configuration" do
      assert render_chart(@configured_chart) =~ "stroke=\"green\""

      assert render_chart(@configured_chart) =~ "stroke-width=\"7px\""
    end

    test "renders table without inline styles when show_table is true" do
      refute render_chart(Map.put(@base_chart, :show_table, true)) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end

    test "renders table with inline styles when show_table is false" do
      assert render_chart(@base_chart) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end
  end

  def grid_line_fun({min, max}, _step) do
    Enum.take_every(min..max, 500)
  end
end
