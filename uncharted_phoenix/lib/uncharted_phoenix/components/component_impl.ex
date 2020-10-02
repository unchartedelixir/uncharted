defimpl Uncharted.Component, for: Uncharted.BarChart.Dataset do
  def for_dataset(_dataset), do: UnchartedPhoenix.LiveBarComponent
end

defimpl Uncharted.Component, for: Uncharted.ColumnChart.Dataset do
  def for_dataset(%{axes: axes}) do
    case axes do
      %{x: _x_axis, y: _y_axis} -> UnchartedPhoenix.LiveLineComponent
      _ -> UnchartedPhoenix.LiveColumnComponent
    end
  end
end

defimpl Uncharted.Component, for: Uncharted.PieChart.Dataset do
  def for_dataset(_dataset), do: UnchartedPhoenix.LivePieComponent
end

defimpl Uncharted.Component, for: Uncharted.ProgressChart.Dataset do
  def for_dataset(_dataset), do: UnchartedPhoenix.LiveProgressComponent
end
