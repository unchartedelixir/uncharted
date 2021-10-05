defimpl Uncharted.DoughnutChart, for: Uncharted.BaseChart do
  alias Uncharted.BaseChart
  alias Uncharted.DoughnutChart.DoughnutSlice

  def doughnut_slices(%BaseChart{dataset: nil}), do: []

  def doughnut_slices(%BaseChart{dataset: %{data: []}}), do: []

  def doughnut_slices(%BaseChart{dataset: %{data: data}}) do
    data
    |> Enum.map(fn datum ->
      %DoughnutSlice{
        label: datum.name,
        percentage: hd(datum.values),
        fill_color: datum.fill_color
      }
    end)
  end
end
