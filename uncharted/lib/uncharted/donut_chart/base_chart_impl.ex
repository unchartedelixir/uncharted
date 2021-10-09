defimpl Uncharted.DonutChart, for: Uncharted.BaseChart do
  alias Uncharted.BaseChart
  alias Uncharted.DonutChart.DonutSlice

  def donut_slices(%BaseChart{dataset: nil}), do: []

  def donut_slices(%BaseChart{dataset: %{data: []}}), do: []

  def donut_slices(%BaseChart{dataset: %{data: data}}) do
    data
    |> Enum.map(fn datum ->
      %DonutSlice{
        label: datum.name,
        percentage: hd(datum.values),
        fill_color: datum.fill_color
      }
    end)
  end
end
