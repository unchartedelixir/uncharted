defmodule UnchartedPhoenix.LiveDonutComponentTest do
  alias Uncharted.DonutChart.Dataset
  import UnchartedPhoenix.TestRenderer
  use ExUnit.Case

  @base_chart %Uncharted.BaseChart{
    title: "this title",
    dataset: %Dataset{
      data: [],
      center_value: 33,
      label: "Most important",
      secondary_label: "Less important"
    }
  }

  describe "LiveDonut" do
    test "renders donut" do
      assert render_chart(@base_chart) =~ ~s(data-testid="lc-live-donut-component")
    end

    test "renders a chart's title" do
      assert render_chart(@base_chart) =~ @base_chart.title
    end

    test "renders table without inline styles when show_table is true" do
      refute render_chart(Map.put(@base_chart, :show_table, true)) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end

    test "renders table with inline styles when show_table is false" do
      assert render_chart(@base_chart) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end

    test "renders a center section value and labels" do
      assert render_chart(@base_chart) =~ "#{@base_chart.dataset.center_value}"
      assert render_chart(@base_chart) =~ @base_chart.dataset.label
      assert render_chart(@base_chart) =~ @base_chart.dataset.secondary_label
    end
  end
end
