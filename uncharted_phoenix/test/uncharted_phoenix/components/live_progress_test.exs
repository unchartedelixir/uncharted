defmodule UnchartedPhoenix.LiveProgressComponentTest do
  alias Uncharted.BaseChart
  alias Uncharted.ProgressChart
  alias Uncharted.ProgressChart.Dataset
  import UnchartedPhoenix.TestRenderer
  use ExUnit.Case

  @chart %BaseChart{
    title: "my progress chart",
    colors: %{gray: "#e2e2e2"},
    dataset: %Dataset{
      background_stroke_color: :gray,
      label: "Unchartedness",
      to_value: 100,
      current_value: 45,
      percentage_text_fill_color: :red_gradient,
      percentage_fill_color: :rosy_gradient,
      label_fill_color: :rosy_gradient
    }
  }

  describe "LiveProgress component" do
    test "render/1 mounts successfully" do
      assert render_chart(@chart) =~ ~s(data-testid="lc-live-progress-component")
    end

    test "renders title for accessibility" do
      assert render_chart(@chart) =~ @chart.title
    end

    test "it renders the percentage" do
      assert render_chart(@chart) =~ "#{ProgressChart.progress(@chart)}"
    end

    test "renders table without inline styles when show_table is true" do
      refute render_chart(Map.put(@chart, :show_table, true)) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end

    test "renders table with inline styles when show_table is false" do
      assert render_chart(@chart) =~
               "style=\"position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;\""
    end
  end
end
