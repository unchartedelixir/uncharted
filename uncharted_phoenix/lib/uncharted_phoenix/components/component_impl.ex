defimpl Uncharted.Component, for: Uncharted.BaseChart do
  alias Uncharted.BaseChart
  alias Uncharted.BarChart
  alias Uncharted.ColumnChart
  alias Uncharted.LineChart
  alias Uncharted.PieChart
  alias Uncharted.ProgressChart
  alias Uncharted.ScatterPlot

  def for_dataset(%BaseChart{dataset: dataset}) do
    case dataset do
      %BarChart.Dataset{} -> UnchartedPhoenix.LiveBarComponent
      %ColumnChart.Dataset{} -> UnchartedPhoenix.LiveColumnComponent
      %LineChart.Dataset{} -> UnchartedPhoenix.LiveLineComponent
      %PieChart.Dataset{} -> UnchartedPhoenix.LivePieComponent
      %ProgressChart.Dataset{} -> UnchartedPhoenix.LiveProgressComponent
      %ScatterPlot.Dataset{} -> UnchartedPhoenix.LiveScatterComponent
      dataset -> raise UnchartedPhoenix.ComponentUndefinedError, message: error_message(dataset)
    end
  end

  def id(%BaseChart{component_id: nil, dataset: dataset}) do
    strip_prefix(Atom.to_string(dataset.__struct__))
  end

  def id(%BaseChart{component_id: id, dataset: dataset}) when is_binary(id) do
    strip_prefix(Atom.to_string(dataset.__struct__) <> "__" <> id)
  end

  def id(%BaseChart{component_id: id, dataset: dataset}) when is_number(id) do
    strip_prefix(Atom.to_string(dataset.__struct__) <> "__" <> "#{id}")
  end

  def error_message(dataset) do
    """
    No UnchartedPhoenix Component defined for dataset: #{inspect(dataset)}.
    To define your own Component, implement the Uncharted.Component protocol for your own chart and datasets.
    """
  end

  defp strip_prefix(id) do
    String.replace(id, "Elixir.", "")
  end
end
