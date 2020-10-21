defmodule UnchartedPhoenix.LiveColumnComponent do
  @moduledoc """
  Column Chart Component
  """

  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    y_axis = assigns.chart.dataset.axes.magnitude_axis
    # Hardcode the number of steps to take as 5 for now
    grid_lines = y_axis.grid_lines.({y_axis.min, y_axis.max}, 5)
    grid_line_offsetter = fn grid_line -> 100 * (y_axis.max - grid_line) / y_axis.max end

    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:columns, Uncharted.ColumnChart.columns(assigns.chart))
      |> assign(:grid_lines, grid_lines)
      |> assign(:grid_line_offsetter, grid_line_offsetter)
      |> assign(:axis, y_axis)
      |> assign(:show_table, assigns.show_table)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_column.html", assigns)
  end

  def handle_event("show_table", _, socket) do
    {:noreply, assign(socket, :show_table, true)}
  end

  def handle_event("hide_table", _, socket) do
    {:noreply, assign(socket, :show_table, false)}
  end
end
