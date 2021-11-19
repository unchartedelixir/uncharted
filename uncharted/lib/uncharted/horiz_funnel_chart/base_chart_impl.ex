defimpl Uncharted.HorizontalFunnelChart, for: Uncharted.BaseChart do
  alias Uncharted.{BaseChart, Section}
  alias Uncharted.HorizontalFunnelChart.{Bar, BarSection, Dataset}

  def bars(%BaseChart{dataset: nil}), do: []

  def bars(%BaseChart{dataset: dataset, width: width, height: height}),
    do: bars(dataset, width, height)

  def bars(%Dataset{data: []}, _chart_width, _chart_height), do: []

  def bars(%Dataset{data: data, sections: sections}, chart_width, chart_height) do
    width = 100.0 / Enum.count(data)

    longest_bar =
      data
      |> Enum.max(&(Enum.sum(&1.values) > Enum.sum(&2.values)))

    longest_bar_value =
      longest_bar.values
      |> Enum.sum()

    data
    |> Enum.with_index()
    |> Enum.map(fn {datum, index} ->
      offset = index * width
      bar_value = full_bar_value(datum.values)
      bar_percentage = bar_value / longest_bar_value * 100
      funnel_width = (chart_width || 600) * 0.92
      funnel_height = (chart_height || 400) * 0.96 * 0.8

      %Bar{
        label: datum.name,
        width: width,
        offset: offset,
        full_bar_value: bar_value,
        full_bar_percentage: bar_percentage,
        sections:
          bar_sections(
            datum,
            data,
            longest_bar_value,
            %{width: funnel_width, height: funnel_height},
            width,
            bar_value,
            sections,
            index
          )
      }
    end)
  end

  def bar_sections(
        %Uncharted.BaseDatum{} = datum,
        bars,
        max,
        %{width: chart_width, height: chart_height},
        bar_width,
        full_bar_value,
        sections,
        bar_index
      )
      when length(sections) < 2 do
    value = hd(datum.values)
    bar_height = hd(datum.values) / max * 100
    section_offset = section_offset(datum.values, 0, max, full_bar_value)
    next_section_offset_start = next_section_offset(0, bar_index, bars, max, false)
    next_section_offset_end = next_section_offset(0, bar_index, bars, max, true)

    [
      %BarSection{
        label: datum.name,
        bar_height: bar_height,
        bar_value: value,
        fill_color: datum.fill_color,
        y_points:
          [
            section_offset,
            section_offset + value,
            next_section_offset_end,
            next_section_offset_start
          ]
          |> Enum.map(&(&1 / max * chart_height)),
        x_points:
          [bar_index, bar_index + 0.5, bar_index + 1]
          |> Enum.map(&(&1 * bar_width * chart_width / 100))
      }
    ]
  end

  def bar_sections(
        %Uncharted.BaseDatum{values: values} = data,
        bars,
        max,
        %{width: chart_width, height: chart_height},
        bar_width,
        full_bar_value,
        sections,
        bar_index
      ) do
    values
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      bar_height = percentage(value, max)

      %Section{label: section_label, fill_color: fill_color} =
        sections
        |> Enum.with_index()
        |> Enum.find(fn {%Section{index: section_index}, i} -> (section_index || i) == index end)
        |> elem(0)

      section_offset = section_offset(values, index, max, full_bar_value)
      next_section_offset_start = next_section_offset(index, bar_index, bars, max, false)
      next_section_offset_end = next_section_offset(index, bar_index, bars, max, true)

      %BarSection{
        label: "#{data.name}, #{section_label}",
        bar_height: bar_height,
        bar_value: value,
        fill_color: fill_color,
        y_points:
          [
            section_offset,
            section_offset + value,
            next_section_offset_end,
            next_section_offset_start
          ]
          |> Enum.map(&(&1 / max * chart_height)),
        x_points:
          [bar_index, bar_index + 0.5, bar_index + 1]
          |> Enum.map(&(&1 * bar_width * chart_width / 100))
      }
    end)
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

    existing_bar_value(next_bar_values, section_index) + bar_offset(max, full_value) +
      Enum.at(next_bar_values, section_index, 0)
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
