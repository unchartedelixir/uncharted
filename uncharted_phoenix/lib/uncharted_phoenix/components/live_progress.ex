defmodule UnchartedPhoenix.LiveProgressComponent do
  @moduledoc """
  Bar Progress Component
  """

  alias Uncharted.ProgressChart
  use Phoenix.LiveComponent
  use UnchartedPhoenix.TableEvents

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:chart, assigns.chart)
      |> assign(:data, ProgressChart.data(assigns.chart))
      |> assign(:progress, ProgressChart.progress(assigns.chart))
      |> assign(:always_show_table, assigns.always_show_table)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(UnchartedPhoenix.ComponentView, "live_progress.html", assigns)
  end
end
