defmodule UnchartedPhoenix.LivePieComponent do
  @moduledoc """
  Pie Chart Component
  """

  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, :show_table, false)}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:pie_slices, Uncharted.PieChart.pie_slices(assigns.chart))
      |> assign(:show_table, assigns.chart.show_table)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_pie.html", assigns)
  end

  def handle_event("show_table", _, socket) do
    {:noreply, assign(socket, :show_table, true)}
  end

  def handle_event("hide_table", _, socket) do
    {:noreply, assign(socket, :show_table, false)}
  end
end
