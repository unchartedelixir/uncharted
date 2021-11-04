defmodule UnchartedPhoenix.LivePieComponent do
  @moduledoc """
  Pie Chart Component
  """

  use Phoenix.LiveComponent
  use UnchartedPhoenix.SharedEvents

  def update(assigns, socket) do
    socket =
      socket
      |> shared_update(assigns)
      |> assign(:pie_slices, Uncharted.PieChart.pie_slices(assigns.chart))

    {:ok, socket}
  end
end
