defmodule UnchartedPhoenix.LiveDoughnutComponentTest do
  alias Uncharted.DoughnutChart.Dataset
  import UnchartedPhoenix.TestRenderer
  use ExUnit.Case
  @base_chart %Uncharted.BaseChart{title: "this title", dataset: %Dataset{data: []}}

  describe "LiveDoughnut" do
    test "renders doughnut" do
      assert render_chart(@base_chart) =~ ~s(data-testid="lc-live-doughnut-component")
    end

    test "renders a chart's title" do
      assert render_chart(@base_chart) =~ @base_chart.title
    end

    test "renders table without inline styles when show_table is true" do
      refute render_chart(Map.put(@base_chart, :show_table, true)) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end

    test "renders table with inline styles when show_table is calse" do
      assert render_chart(@base_chart) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end
  end
end
