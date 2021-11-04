defmodule UnchartedPhoenix.LiveColumnComponent do
  @moduledoc """
  Column Chart Component
  """

  use Phoenix.LiveComponent
  use UnchartedPhoenix.SharedEvents

  def update(assigns, socket) do
    y_axis = assigns.chart.dataset.axes.magnitude_axis
    # Hardcode the number of steps to take as 5 for now
    grid_lines = y_axis.grid_lines.({y_axis.min, y_axis.max}, 5)
    grid_line_offsetter = fn grid_line -> 100 * (y_axis.max - grid_line) / y_axis.max end

    socket =
      socket
      |> shared_update(assigns)
      |> assign(:columns, Uncharted.ColumnChart.columns(assigns.chart))
      |> assign(:grid_lines, grid_lines)
      |> assign(:grid_line_offsetter, grid_line_offsetter)
      |> assign(:axis, y_axis)
      |> assign(:width, assigns.chart.width || 700)
      |> assign(:height, assigns.chart.height || 400)

    {:ok, socket}
  end
end
