defmodule UnchartedPhoenix do
  alias Uncharted.Component
  import Phoenix.LiveView.Helpers
  @moduledoc false

  def render(socket, chart) do
    live_component(socket, Component.for_dataset(chart.dataset), chart: chart)
  end
end
