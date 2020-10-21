defprotocol Uncharted.Component do
  @moduledoc """
  The `Uncharted.Component` protocol allows client libraries to provide
  custom visualizations (i.e., components) that are dependent on the type
  of chart and dataset being passed in to the protocol.

  For example, `UnchartedPhoenix` provides several LiveView components for
  the built-in `Uncharted` datasets: `Uncharted.BarChart.Dataset`, `Uncharted.ColumnChart.Dataset`,
  `Uncharted.PieChart.Dataset`, and `Uncharted.ProgressChart.Dataset`. By implementing
  the `Uncharted.Component` protocol for each `Uncharted.BaseChart`, `UnchartedPhoenix` can shell
  out the visualization aspect of the charts to its own LiveView components.

  The following shows the implementation in `UnchartedPhoenix` for a bar chart
  dataset.

  ```elixir
  defimpl Uncharted.Component, for: Uncharted.BaseChart do
    def for_dataset(%Uncharted.Basechart{dataset: %Uncharted.BarChart.Dataset{}}) do
      UnchartedPhoenix.LiveBarComponent
    end
  end
  ```

  Users can implement this protocol for their own custom datasets and even
  provide custom components (i.e., in the context of Phoenix LiveView, you
  can create your own custom LiveView component).
  """

  @type user_defined_dataset :: term()

  @doc """
  Returns a visualization for the given dataset.
  """
  @spec for_dataset(Uncharted.gen_chart() | user_defined_dataset) :: term
  def for_dataset(dataset)

  @doc """
  Returns an id for the given dataset.
  """
  @spec id(Uncharted.gen_chart() | user_defined_dataset()) :: term()
  def id(component)
end
