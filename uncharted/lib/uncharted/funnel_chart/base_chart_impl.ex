defimpl Uncharted.FunnelChart, for: Uncharted.BaseChart do
  alias Uncharted.{BaseChart, Section}
  alias Uncharted.FunnelChart.{Bar, BarSection, Dataset}

  def bars(%BaseChart{dataset: nil}), do: []
  def bars(%BaseChart{dataset: dataset}), do: bars(dataset)
  def bars(%Dataset{data: []}), do: []

  def bars(%Dataset{data: data, sections: sections}) do
    height = 100.0 / Enum.count(data)
    longest_bar = data
    |> Enum.max(& Enum.sum(&1.values) > Enum.sum(&2.values))
    longest_bar_value = longest_bar.values
    |> Enum.sum()

    data
    |> Enum.with_index()
    |> Enum.map(fn {datum, index} ->
      offset = index * height
      bar_value = full_bar_value(datum.values)
      bar_percentage = bar_value / longest_bar_value * 100

      %Bar{
        label: datum.name,
        height: height,
        offset: offset,
        full_bar_value: bar_value,
        full_bar_percentage: bar_percentage,
        bar_offset: offset,
        bar_height: height,
        sections: bar_sections(datum, data, longest_bar_value, bar_value, sections, index)
      }
    end)
  end

  def bar_sections(%Uncharted.BaseDatum{} = datum, bars, max, full_bar_value, [], bar_index) do
    value = hd(datum.values)
    bar_width = hd(datum.values) / max * 100
    offset = section_offset(datum.values, 0, max, full_bar_value)
    [
      %BarSection{
        label: datum.name,
        offset: percentage(offset, max),
        offset_end: percentage(offset + value, max),
        lower_offset: next_section_offset(0, bar_index, bars, max, false) |> percentage(max),
        lower_offset_end: next_section_offset(0, bar_index, bars, max, true) |> percentage(max),
        bar_width: bar_width,
        bar_value: value,
        fill_color: datum.fill_color
      }
    ]
  end

  def bar_sections(%Uncharted.BaseDatum{values: values} = data, bars, max, full_bar_value, sections, bar_index) do
    values
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      bar_width = percentage(value, max)

      %Section{label: section_label, fill_color: fill_color} =
        sections
        |> Enum.with_index()
        |> Enum.find(fn {%Section{index: section_index}, i} -> (section_index || i) == index end)
        |> elem(0)

        section_offset = section_offset(values, index, max, full_bar_value)

      %BarSection{
        label: "#{data.name}, #{section_label}",
        offset: percentage(section_offset, max),
        offset_end: percentage(section_offset + value, max),
        lower_offset: next_section_offset(index, bar_index, bars, max, false) |> percentage(max),
        lower_offset_end: next_section_offset(index, bar_index, bars, max, true) |> percentage(max),
        bar_width: bar_width,
        bar_value: value,
        fill_color: fill_color
      }
    end)
  end

  defp max_bar_value(data) do
    data
    |> Enum.map(&full_bar_value(&1.values))
    |> Enum.max()
  end

  defp full_bar_value(values) do
    values
    |> Enum.sum()
  end

  defp section_offset(values, index, max, full_bar_value) do
    existing_bar_value(values, index) + bar_offset(max, full_bar_value)
  end

  defp next_section_offset(section_index, bar_index, bars, max, true) do
    next_bar_values = Enum.at(bars, bar_index + 1, Enum.at(bars, bar_index)).values
    full_value = Enum.sum(next_bar_values)

     existing_bar_value(next_bar_values, section_index) + bar_offset(max, full_value) + Enum.at(next_bar_values, section_index, 0)
  end

  defp next_section_offset(section_index, bar_index, bars, max, false) do
    next_bar_values = Enum.at(bars, bar_index + 1, Enum.at(bars, bar_index)).values
    full_value = Enum.sum(next_bar_values)

    existing_bar_value(next_bar_values, section_index) + bar_offset(max, full_value)
  end

  defp existing_bar_value(values, index) do
    values
    |> Enum.slice(0, index)
    |> Enum.sum()
  end

  defp bar_offset(max, full_bar_value), do: (max - full_bar_value) / 2

  defp percentage(value, max), do: value / max * 100
end
