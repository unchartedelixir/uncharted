defimpl Uncharted.BarChart, for: Uncharted.BaseChart do
  alias Uncharted.BaseChart
  alias Uncharted.BarChart.{Bar, BarSection, Dataset, Section}

  def bars(%BaseChart{dataset: nil}), do: []
  def bars(%BaseChart{dataset: dataset}), do: bars(dataset)
  def bars(%Dataset{data: []}), do: []

  def bars(%Dataset{data: data, sections: sections, axes: %{magnitude_axis: %{max: max}}}) do
    height = 100.0 / Enum.count(data)
    margin = height / 4.0

    data
    |> Enum.with_index()
    |> Enum.map(fn {datum, index} ->
      offset = index * height

      %Bar{
        label: datum.name,
        height: height,
        offset: offset,
        bar_offset: offset + margin,
        bar_height: height / 2.0,
        sections: bar_sections(datum, max, sections)
      }
    end)
  end

  def bar_sections(%Uncharted.BaseDatum{} = datum, max, []) do
    value = hd(datum.values)
    bar_width = hd(datum.values) / max * 100

    [
      %BarSection{
        label: datum.name,
        offset: section_offset(datum.values, 0, max),
        bar_width: bar_width,
        bar_value: value,
        fill_color: datum.fill_color
      }
    ]
  end

  def bar_sections(%Uncharted.BaseDatum{values: values} = data, max, sections) do
    values
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      bar_width = value / max * 100

      %Section{label: section_label, fill_color: fill_color} =
        sections
        |> Enum.with_index()
        |> Enum.find(fn {%Section{index: section_index}, i} -> (section_index || i) == index end)
        |> elem(0)

      %BarSection{
        label: "#{data.name}, #{section_label}",
        offset: section_offset(values, index, max),
        bar_width: bar_width,
        bar_value: value,
        fill_color: fill_color
      }
    end)
  end

  defp section_offset(values, index, max) do
    previous_bar_value =
      values
      |> Enum.slice(0, index)
      |> Enum.sum()

    previous_bar_value / max * 100
  end
end
