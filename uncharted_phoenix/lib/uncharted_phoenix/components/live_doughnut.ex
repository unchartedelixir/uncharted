defmodule UnchartedPhoenix.LiveDoughnutComponent do
  @moduledoc """
  Doughnut Chart Component
  """

  use Phoenix.LiveComponent
  use UnchartedPhoenix.SharedEvents

  def update(assigns, socket) do
    socket =
      socket
      |> shared_update(assigns)
      |> assign(:doughnut_slices, Uncharted.DoughnutChart.doughnut_slices(assigns.chart))

    {:ok, socket}
  end
end
