defmodule UnchartedPhoenix.LiveHorizontalFunnelComponent do
  @moduledoc """
  Funnel Chart Component
  """

  use Phoenix.LiveComponent
  use UnchartedPhoenix.SharedEvents

  def update(assigns, socket) do
    x_axis = assigns.chart.dataset.axes.magnitude_axis
    # Hardcode the number of steps to take as 10 for now
    grid_lines =
      x_axis.grid_lines.({x_axis.min, x_axis.max}, Enum.count(assigns.chart.dataset.data))

    grid_line_offsetter = fn grid_line ->
      result = 100 * grid_line / x_axis.max
      result
    end

    socket =
      socket
      |> shared_update(assigns)
      |> assign(:columns, Uncharted.HorizontalFunnelChart.bars(assigns.chart))
      |> assign(:grid_lines, grid_lines)
      |> assign(:offsetter, grid_line_offsetter)
      |> assign(:axis, x_axis)
      |> assign(:width, assigns.chart.width || 600)
      |> assign(:height, assigns.chart.height || 400)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_horiz_funnel.html", assigns)
  end
end
