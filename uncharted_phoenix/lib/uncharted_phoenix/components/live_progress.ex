defmodule UnchartedPhoenix.LiveProgressComponent do
  @moduledoc """
  Bar Progress Component
  """

  alias Uncharted.ProgressChart
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:data, ProgressChart.data(assigns.chart))
      |> assign(:progress, ProgressChart.progress(assigns.chart))
      |> assign(:show_table, assigns.show_table)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_progress.html", assigns)
  end

  def handle_event("show_table", _, socket) do
    {:noreply, assign(socket, :show_table, true)}
  end

  def handle_event("hide_table", _, socket) do
    {:noreply, assign(socket, :show_table, false)}
  end
end
