defmodule UnchartedPhoenix.LivePieComponent do
  @moduledoc """
  Pie Chart Component
  """

  use Phoenix.LiveComponent
  use UnchartedPhoenix.TableEvents

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:pie_slices, Uncharted.PieChart.pie_slices(assigns.chart))
      |> assign(:always_show_table, assigns.always_show_table)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_pie.html", assigns)
  end
end
