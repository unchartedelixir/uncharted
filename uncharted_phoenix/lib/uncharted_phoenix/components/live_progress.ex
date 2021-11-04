defmodule UnchartedPhoenix.LiveProgressComponent do
  @moduledoc """
  Bar Progress Component
  """

  alias Uncharted.ProgressChart
  use Phoenix.LiveComponent
  use UnchartedPhoenix.SharedEvents

  def update(assigns, socket) do
    socket =
      socket
      |> shared_update(assigns)
      |> assign(:data, ProgressChart.data(assigns.chart))
      |> assign(:progress, ProgressChart.progress(assigns.chart))

    {:ok, socket}
  end
end
