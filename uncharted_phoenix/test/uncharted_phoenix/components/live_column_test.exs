defmodule UnchartedPhoenix.LiveColumnComponentTest do
  alias Uncharted.BaseChart
  alias Uncharted.Axes.{BaseAxes, MagnitudeAxis}
  alias Uncharted.ColumnChart.Dataset
  import UnchartedPhoenix.TestRenderer
  use ExUnit.Case

  @axes %BaseAxes{
    magnitude_axis: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2
    }
  }
  @configured_axes %BaseAxes{
    magnitude_axis: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2,
      line_color: "red",
      line_width: 7
    }
  }
  @nondisplayed_axes %BaseAxes{
    magnitude_axis: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2,
      line_color: "red",
      line_width: 7,
      display_lines: false
    }
  }
  @base_chart %BaseChart{title: "this title", dataset: %Dataset{axes: @axes, data: []}}
  @configured_graph_chart %BaseChart{dataset: %Dataset{axes: @configured_axes, data: []}}
  @nondisplayed_graph_chart %BaseChart{dataset: %Dataset{axes: @nondisplayed_axes, data: []}}

  describe "LiveColumnComponent" do
    test "renders" do
      assert render_chart(@base_chart) =~ ~s(data-testid="lc-live-column-component")
    end

    test "renders the chart's title" do
      assert render_chart(@base_chart) =~ @base_chart.title
    end

    test "renders grid lines according to configuration" do
      assert render_chart(@configured_graph_chart) =~ "stroke=\"red\""

      assert render_chart(@configured_graph_chart) =~ "stroke-width=\"7px\""

      refute render_chart(@nondisplayed_graph_chart) =~ "stroke=\"red\""

      refute render_chart(@nondisplayed_graph_chart) =~ "stroke-width=\"7px\""
    end

    test "renders table without inline styles when show_table is true" do
      assert render_chart(Map.put(@base_chart, :show_table, true)) =~ "style=\"\">"
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
