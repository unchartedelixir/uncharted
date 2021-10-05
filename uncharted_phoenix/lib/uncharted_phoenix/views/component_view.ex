defmodule UnchartedPhoenix.ComponentView do
  use Phoenix.View,
    root: "lib/uncharted_phoenix/components",
    namespace: UnchartedPhoenix,
    path: ""

  use Phoenix.HTML

  alias Uncharted.{Chart, Gradient}
  alias Uncharted.ColumnChart.Column
  alias Uncharted.LineChart.{Line, Point}
  alias Uncharted.ScatterPlot.Point, as: ScatterPoint

  def color_to_fill(colors, name, is_line \\ false) do
    case Map.get(colors, name, nil) do
      %Gradient{} -> "url(##{Atom.to_string(name) <> if is_line, do: "_line", else: ""})"
      nil -> name
      value -> value
    end
  end

  def svg_id(chart, suffix) do
    base =
      chart
      |> Chart.title()
      |> String.downcase()
      |> String.replace(~r(\s+), "-")

    base <> "-" <> suffix
  end

  def svg_pie_slices(nil), do: []
  def svg_pie_slices([]), do: []

  def svg_pie_slices(pie_slices) do
    label_width = 100 / Enum.count(pie_slices)

    pie_slices
    |> Enum.with_index()
    |> Enum.reduce([], fn {pie_slice, index}, acc ->
      remaining_percentage =
        100 - Enum.reduce(acc, 0, fn slice, sum -> sum + slice.percentage end)

      svg_slice =
        pie_slice
        |> Map.from_struct()
        |> Map.put(:remaining_percentage, remaining_percentage)
        |> Map.put(:label_width, label_width)
        |> Map.put(:label_position, index * label_width)

      [svg_slice | acc]
    end)
    |> Enum.reverse()
  end

  def svg_doughnut_slices(nil), do: []
  def svg_doughnut_slices([]), do: []

  def svg_doughnut_slices(doughnut_slices) do
    label_width = 100 / Enum.count(doughnut_slices)

    doughnut_slices
    |> Enum.with_index()
    |> Enum.reduce([], fn {doughnut_slice, index}, acc ->
      remaining_percentage =
        100 - Enum.reduce(acc, 0, fn slice, sum -> sum + slice.percentage end)

      svg_slice =
        doughnut_slice
        |> Map.from_struct()
        |> Map.put(:remaining_percentage, remaining_percentage)
        |> Map.put(:label_width, label_width)
        |> Map.put(:label_position, index * label_width)

      [svg_slice | acc]
    end)
    |> Enum.reverse()
  end

  def svg_polyline_points([]), do: ""

  def svg_polyline_points(points) do
    points
    |> Enum.map(fn %Point{x_offset: x, y_offset: y} -> "#{10 * x},#{1000 - 10 * y}" end)
    |> List.insert_at(0, "#{hd(points).x_offset * 10},1000")
    |> List.insert_at(-1, "#{List.last(points).x_offset * 10},1000")
    |> Enum.join(" ")
  end

  def maybe_show_table(true), do: []

  def maybe_show_table(_),
    do: [
      style:
        "position: absolute; left: -100000px; top: auto; height: 1px; width: 1px; overflow: hidden;"
    ]
end
