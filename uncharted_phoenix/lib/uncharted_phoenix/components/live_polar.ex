defmodule UnchartedPhoenix.LivePolarComponent do
  @moduledoc """
  Line Polar Component
  """

  use Phoenix.LiveComponent

  def update(assigns, socket) do
    r_axis = assigns.chart.dataset.axes.r
    t_axis = assigns.chart.dataset.axes.t
    # # Hardcode the number of steps to take as 5 for now
    r_grid_lines = r_axis.grid_lines.({r_axis.min, r_axis.max}, 4)
    r_grid_line_offsetter = fn grid_line -> (r_axis.max - grid_line) / r_axis.max end

    t_grid_lines = t_axis.grid_lines.({t_axis.min, t_axis.max}, 4)
    t_grid_line_offsetter = fn grid_line -> (t_axis.max - grid_line) / t_axis.max end

    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:points, Uncharted.PolarChart.points(assigns.chart))
      |> assign(:r_grid_lines, r_grid_lines)
      |> assign(:r_grid_line_offsetter, r_grid_line_offsetter)
      |> assign(:t_grid_lines, t_grid_lines)
      |> assign(:t_grid_line_offsetter, t_grid_line_offsetter)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_polar.html", assigns)
  end
end
