defmodule UnchartedPhoenix.TestRenderer do
  import Phoenix.LiveViewTest

  @endpoint Endpoint

  defmodule DummyLiveComponent do
    @moduledoc """
    This dummy component is designed to embed a call to the `UnchartedPhoenix` top-level
    render API so we can write tests against valid inputs to these calls without requiring
    a fully-mounted LiveView. This prevents us from having to add a lot of overhead because
    a full LiveView process would require us to setup a router and rely on Phoenix for other
    dependencies that are not strictly required for UnchartedPhoenix itself.
    """
    use Phoenix.LiveComponent

    def render(assigns) do
      ~L"""
      <div>
        <%= if assigns.chart do %>
          <%= UnchartedPhoenix.render(@socket, assigns.chart) %>
        <% end %>
      </div>
      """
    end
  end

  @doc """
  A helper function for UnchartedPhoenix tests that will render the UnchartedPhoenix
  component inside of a live component. This will ensure consistency around the way
  UnchartedPhoenix components are invoked and rendered.

  As long as a valid `Uncharted.gen_chart` is passed in, the chart will be rendered within
  a dummy LiveView component using LiveViewTest `render_component/3` macro.
  """
  def render_chart(chart) do
    render_component(DummyLiveComponent, chart: chart)
  end
end
