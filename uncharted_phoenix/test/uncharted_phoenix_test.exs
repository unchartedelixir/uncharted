defmodule UnchartedPhoenixTest do
  use ExUnit.Case
  import Phoenix.LiveViewTest
  alias Uncharted.Axes.{BaseAxes, MagnitudeAxis}
  alias Uncharted.PieChart

  @endpoint ThisIsOnlyNeededForLiveViewTest
  @base_chart %Uncharted.BaseChart{title: "base"}
  @axes %BaseAxes{
    magnitude_axis: %MagnitudeAxis{
      min: 0,
      max: 2500,
      grid_lines: &__MODULE__.grid_line_fun/2
    }
  }

  defmodule DummyLiveComponent do
    @moduledoc """
    This dummy component is designed to embed a call to the `UnchartedPhoenix` top-level
    render API so we can write tests against valid inputs to these calls without requiring
    a fully-mounted LiveView. This prevents us from having to add a lot of overhead because
    a full LiveView process would require us to setup a router and rely on Phoenix for other
    dependencies that are not strictly required for UnchartedPhoenix itself.
    """
    use Phoenix.LiveComponent

    def render(assigns) do
      ~L"""
      <div>
        <%= if assigns.chart do %>
          <%= UnchartedPhoenix.render(@socket, assigns.chart) %>
        <% end %>
      </div>
      """
    end
  end

  describe "render/3" do
    test "creates pie chart components" do
      pie_chart = %Uncharted.BaseChart{@base_chart | dataset: %PieChart.Dataset{data: []}}

      assert render_component(DummyLiveComponent, chart: pie_chart) =~
               ~s(data-testid="lc-live-pie-component")
    end

    test "creates bar chart components" do
      bar_chart = %Uncharted.BaseChart{
        @base_chart
        | dataset: %Uncharted.BarChart.Dataset{data: [], axes: @axes}
      }

      assert render_component(DummyLiveComponent, chart: bar_chart) =~
               ~s(data-testid="lc-live-bar-component")
    end

    test "creates column chart components" do
      column_chart = %Uncharted.BaseChart{
        @base_chart
        | dataset: %Uncharted.ColumnChart.Dataset{data: [], axes: @axes}
      }

      assert render_component(DummyLiveComponent, chart: column_chart) =~
               ~s(data-testid="lc-live-column-component")
    end

    test "creates line chart components" do
      xy_axes = %Uncharted.Axes.XYAxes{x: @axes.magnitude_axis, y: @axes.magnitude_axis}

      line_chart = %Uncharted.BaseChart{
        @base_chart
        | dataset: %Uncharted.LineChart.Dataset{axes: xy_axes, data: []}
      }

      assert render_component(DummyLiveComponent, chart: line_chart) =~
               ~s(data-testid="lc-live-line-component")
    end

    test "creates progress chart components" do
      dataset = %Uncharted.ProgressChart.Dataset{to_value: 100, current_value: 50}

      assert render_component(DummyLiveComponent,
               chart_type: :progress,
               chart: %Uncharted.BaseChart{@base_chart | dataset: dataset}
             ) =~
               ~s(data-testid="lc-live-progress-component")
    end

    test "raises an UnchartedPhoenix.ComponentUndefinedError exception when an invalid chart type is given" do
      assert_raise UnchartedPhoenix.ComponentUndefinedError,
                   ~r/^No UnchartedPhoenix Component defined for dataset/,
                   fn ->
                     render_component(DummyLiveComponent,
                       chart: @base_chart
                     )
                   end
    end
  end

  def grid_line_fun({min, max}, _step) do
    Enum.take_every(min..max, 500)
  end
end
