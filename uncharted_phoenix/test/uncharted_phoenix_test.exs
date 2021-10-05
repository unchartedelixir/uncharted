defmodule UnchartedPhoenixTest do
  use ExUnit.Case
  import UnchartedPhoenix.TestRenderer
  alias Uncharted.Axes.{BaseAxes, MagnitudeAxis, XYAxes}

  alias Uncharted.{
    BarChart,
    BaseChart,
    ColumnChart,
    DoughnutChart,
    LineChart,
    PieChart,
    ProgressChart
  }

  @base_chart %BaseChart{title: "base"}
  @axes %BaseAxes{
    magnitude_axis: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2
    }
  }

  describe "render/3" do
    test "creates pie chart components" do
      pie_chart = %BaseChart{@base_chart | dataset: %PieChart.Dataset{data: []}}

      assert render_chart(pie_chart) =~ ~s(data-testid="lc-live-pie-component")
    end

    test "creates bar chart components" do
      bar_chart = %BaseChart{
        @base_chart
        | dataset: %BarChart.Dataset{data: [], axes: @axes}
      }

      assert render_chart(bar_chart) =~ ~s(data-testid="lc-live-bar-component")
    end

    test "creates column chart components" do
      column_chart = %BaseChart{
        @base_chart
        | dataset: %ColumnChart.Dataset{data: [], axes: @axes}
      }

      assert render_chart(column_chart) =~ ~s(data-testid="lc-live-column-component")
    end

    test "creates line chart components" do
      xy_axes = %XYAxes{x: @axes.magnitude_axis, y: @axes.magnitude_axis}

      line_chart = %BaseChart{
        @base_chart
        | dataset: %LineChart.Dataset{axes: xy_axes, data: []}
      }

      assert render_chart(line_chart) =~ ~s(data-testid="lc-live-line-component")
    end

    test "creates progress chart components" do
      dataset = %ProgressChart.Dataset{to_value: 100, current_value: 50}

      assert render_chart(%BaseChart{@base_chart | dataset: dataset}) =~
               ~s(data-testid="lc-live-progress-component")
    end

    test "creates doughnut chart components" do
      doughnut_chart = %BaseChart{
        @base_chart
        | dataset: %DoughnutChart.Dataset{data: []}
      }

      assert render_chart(doughnut_chart) =~ ~s(data-testid="lc-live-doughnut-component")
    end

    test "raises an UnchartedPhoenix.ComponentUndefinedError exception when an invalid chart type is given" do
      assert_raise UnchartedPhoenix.ComponentUndefinedError,
                   ~r/^No UnchartedPhoenix Component defined for dataset/,
                   fn -> render_chart(@base_chart) end
    end
  end

  def grid_line_fun({min, max}, _step) do
    Enum.take_every(min..max, 500)
  end
end
