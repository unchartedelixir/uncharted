defmodule UnchartedPhoenix.LivePieComponentTest do
  alias Uncharted.Component
  alias Uncharted.PieChart.Dataset
  alias UnchartedPhoenix.LivePieComponent
  import Phoenix.LiveViewTest
  use ExUnit.Case
  @endpoint Endpoint
  @base_chart %Uncharted.BaseChart{title: "this title", dataset: %Dataset{data: []}}

  describe "LivePie" do
    test "renders pie" do
      assert render_component(LivePieComponent, chart: @base_chart, id: Component.id(@base_chart)) =~
               ~s(data-testid="lc-live-pie-component")
    end

    test "renders a chart's title" do
      assert render_component(LivePieComponent, chart: @base_chart, id: Component.id(@base_chart)) =~
               @base_chart.title
    end
  end
end
