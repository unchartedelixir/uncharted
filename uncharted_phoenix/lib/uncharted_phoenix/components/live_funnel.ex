defmodule UnchartedPhoenix.LiveFunnelComponent do
  @moduledoc """
  Funnel Chart Component
  """

  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, :show_table, false)}
  end

  def update(assigns, socket) do
    x_axis = assigns.chart.dataset.axes.magnitude_axis
    # Hardcode the number of steps to take as 10 for now
    grid_lines = x_axis.grid_lines.({x_axis.min, x_axis.max}, Enum.count(assigns.chart.dataset.data))

    grid_line_offsetter = fn grid_line ->
      result = 100 * grid_line / x_axis.max
      result
    end

    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:bars, Uncharted.FunnelChart.bars(assigns.chart))
      |> assign(:grid_lines, grid_lines)
      |> assign(:offsetter, grid_line_offsetter)
      |> assign(:axis, x_axis)
      |> assign(:always_show_table, assigns.always_show_table)
      |> assign(:width, assigns.chart.width || 600)
      |> assign(:height, assigns.chart.height || 400)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_funnel.html", assigns)
  end

  def handle_event("show_table", _, socket) do
    {:noreply, assign(socket, :show_table, true)}
  end

  def handle_event("hide_table", _, socket) do
    {:noreply, assign(socket, :show_table, false)}
  end
end
