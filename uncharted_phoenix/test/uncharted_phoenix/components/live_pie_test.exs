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
  end
end
