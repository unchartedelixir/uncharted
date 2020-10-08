defimpl Uncharted.PolarChart, for: Uncharted.BaseChart do
  alias Uncharted.BaseChart
  alias Uncharted.PolarChart.Dataset
  alias Uncharted.PolarChart.Point

  def points(%BaseChart{dataset: nil}), do: []
  def points(%BaseChart{dataset: dataset}), do: points(dataset)
  def points(%Dataset{data: []}), do: []

  def points(%Dataset{
        data: data
      }) do
    data
    |> Enum.map(fn datum ->
      %Point{
        label: datum.name,
        r: Enum.at(datum.values, 0),
        t: Enum.at(datum.values, 1)
      }
    end)
  end
end
