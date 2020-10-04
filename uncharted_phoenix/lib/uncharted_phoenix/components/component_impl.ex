defimpl Uncharted.Component, for: Uncharted.BarChart.Dataset do
  def for_dataset(_dataset), do: UnchartedPhoenix.LiveBarComponent
end

defimpl Uncharted.Component, for: Uncharted.ColumnChart.Dataset do
  def for_dataset(_dataset), do: UnchartedPhoenix.LiveColumnComponent
end

defimpl Uncharted.Component, for: Uncharted.LineChart.Dataset do
  def for_dataset(_dataset), do: UnchartedPhoenix.LiveLineComponent
end

defimpl Uncharted.Component, for: Uncharted.PieChart.Dataset do
  def for_dataset(_dataset), do: UnchartedPhoenix.LivePieComponent
end

defimpl Uncharted.Component, for: Uncharted.ProgressChart.Dataset do
  def for_dataset(_dataset), do: UnchartedPhoenix.LiveProgressComponent
end
