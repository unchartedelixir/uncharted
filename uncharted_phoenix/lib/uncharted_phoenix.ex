defmodule UnchartedPhoenix do
  alias Uncharted.Component
  import Phoenix.LiveView.Helpers
  @moduledoc false

  def render(socket, chart) do
    live_component(socket, Component.for_dataset(chart),
      chart: chart,
      id: Component.id(chart)
    )
  end
end
