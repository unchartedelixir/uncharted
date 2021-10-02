defmodule UnchartedPhoenix.LiveStackedColumnComponentTest do
  alias Uncharted.BaseChart
  alias Uncharted.Axes.{BaseAxes, MagnitudeAxis}
  alias Uncharted.StackedColumnChart.{Dataset, Section}
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
  @colors %{blue: "blue"}
  @sections [
    %Section{fill_color: "blue", label: "Section 2", index: 1},
    %Section{fill_color: "blue", label: "Section 1", index: 0}
  ]
  @base_chart %BaseChart{title: "this title", colors: @colors, dataset: %Dataset{axes: @axes, sections: @sections, data: []}}
  @configured_graph_chart %BaseChart{colors: @colors, dataset: %Dataset{axes: @configured_axes, sections: @sections, data: []}}
  @nondisplayed_graph_chart %BaseChart{colors: @colors, dataset: %Dataset{axes: @nondisplayed_axes, sections: @sections, data: []}}

  describe "LiveStackedColumnComponent" do
    test "renders" do
      assert render_chart(@base_chart) =~ ~s(data-testid="lc-live-stacked-column-component")
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
      refute render_chart(Map.put(@base_chart, :show_table, true)) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end

    test "renders table with inline styles when show_table is false" do
      assert render_chart(@base_chart) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end

    test "renders color key" do
      assert render_chart(@base_chart) =~ ~s(data-testid="lc-color-key")
    end
  end

  def grid_line_fun({min, max}, _step) do
    Enum.take_every(min..max, 500)
  end
end
