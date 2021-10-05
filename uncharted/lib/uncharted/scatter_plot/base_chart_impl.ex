defimpl Uncharted.ScatterPlot, for: Uncharted.BaseChart do
  alias Uncharted.BaseChart
  alias Uncharted.ScatterPlot.Dataset
  alias Uncharted.ScatterPlot.Point

  def points(%BaseChart{dataset: nil}), do: []
  def points(%BaseChart{dataset: dataset}), do: points(dataset)
  def points(%Dataset{data: []}), do: []

  def points(%Dataset{
        data: data,
        axes: %{x: %{min: x_min, max: x_max}, y: %{min: y_min, max: y_max}}
      }) do
    data
    |> Enum.map(fn datum ->
      x_offset = Enum.at(datum.values, 0) / (x_max - x_min) * 100
      y_offset = Enum.at(datum.values, 1) / (y_max - y_min) * 100

      %Point{
        label: datum.name,
        fill_color: datum.fill_color,
        radius: Enum.at(datum.values, 2) || Point.__struct__().radius,
        x_offset: x_offset,
        y_offset: y_offset,
        x_value: Enum.at(datum.values, 0),
        y_value: Enum.at(datum.values, 1)
      }
    end)
  end
end
