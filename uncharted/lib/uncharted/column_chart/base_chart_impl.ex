defimpl Uncharted.ColumnChart, for: Uncharted.BaseChart do
  alias Uncharted.BaseChart
  alias Uncharted.ColumnChart.{Column, ColumnSection, Dataset, Section}

  def columns(%BaseChart{dataset: nil}), do: []
  def columns(%BaseChart{dataset: dataset}), do: columns(dataset)
  def columns(%Dataset{data: []}), do: []

  def columns(%Dataset{data: data, axes: %{magnitude_axis: %{max: max}}, sections: sections}) do
    width = 100.0 / Enum.count(data)
    margin = width / 4.0

    data
    |> Enum.with_index()
    |> Enum.map(fn {datum, index} ->
      offset = index * width

      %Column{
        label: datum.name,
        width: width,
        offset: offset,
        bar_offset: offset + margin,
        bar_width: width / 2.0,
        sections: column_sections(datum, max, sections)
      }
    end)
  end

  def column_sections(%Uncharted.BaseDatum{} = datum, max, []) do
    value = hd(datum.values)
    column_height = hd(datum.values) / max * 100

    [
      %ColumnSection{
        label: datum.name,
        offset: column_height,
        column_height: column_height,
        column_value: value,
        fill_color: datum.fill_color
      }
    ]
  end

  def column_sections(%Uncharted.BaseDatum{values: values} = data, max, sections) do
    values
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      column_height = value / max * 100
      offset = section_offset(values, index, max)

      %Section{label: section_label, fill_color: fill_color} =
        sections
        |> Enum.with_index()
        |> Enum.find(fn {%Section{index: section_index}, i} -> (section_index || i) == index end)
        |> elem(0)

      %ColumnSection{
        label: "#{data.name}, #{section_label}",
        offset: offset,
        column_height: column_height,
        column_value: value,
        fill_color: fill_color
      }
    end)
  end

  defp section_offset(values, index, max) do
    full_column_value = Enum.sum(values)

    previous_column_value =
      values
      |> Enum.slice(0, index)
      |> Enum.sum()

    (full_column_value - previous_column_value) / max * 100
  end
end
