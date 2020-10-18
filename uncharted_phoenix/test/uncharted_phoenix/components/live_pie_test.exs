defmodule UnchartedPhoenix.LivePieComponentTest do
  alias Uncharted.PieChart.Dataset
  import UnchartedPhoenix.TestRenderer
  use ExUnit.Case
  @base_chart %Uncharted.BaseChart{title: "this title", dataset: %Dataset{data: []}}

  describe "LivePie" do
    test "renders pie" do
      assert render_chart(@base_chart) =~ ~s(data-testid="lc-live-pie-component")
    end

    test "renders a chart's title" do
      assert render_chart(@base_chart) =~ @base_chart.title
    end

    test "renders table without inline styles when hide_table is false" do
      assert render_component(LivePieComponent, chart: Map.put(@base_chart, :hide_table, false)) =~
               "<table>"
    end

    test "renders table with inline styles when hide_table is true" do
      assert render_component(LivePieComponent, chart: @base_chart) =~
               "<table style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end
  end
end
