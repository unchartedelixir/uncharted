defmodule UnchartedPhoenix.LiveDonutComponent do
  @moduledoc """
  Donut Chart Component
  """

  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, :show_table, false)}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:donut_slices, Uncharted.DonutChart.donut_slices(assigns.chart))
      |> assign(:always_show_table, assigns.always_show_table)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_donut.html", assigns)
  end

  def handle_event("show_table", _, socket) do
    {:noreply, assign(socket, :show_table, true)}
  end

  def handle_event("hide_table", _, socket) do
    {:noreply, assign(socket, :show_table, false)}
  end
end
