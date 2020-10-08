defmodule UnchartedPhoenix.ComponentView do
  use Phoenix.View,
    root: "lib/uncharted_phoenix/components",
    namespace: UnchartedPhoenix,
    path: ""

  use Phoenix.HTML

  alias Uncharted.{Chart, Gradient}
  alias Uncharted.ColumnChart.Column
  alias Uncharted.LineChart.Line
  alias Uncharted.LineChart.Point, as: CartesianPoint
  alias Uncharted.PolarChart.Point, as: PolarPoint

  def color_to_fill(colors, name) do
    case Map.get(colors, name) do
      %Gradient{} -> "url(##{Atom.to_string(name)})"
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

  def svg_polyline_points([]), do: ""

  def svg_polyline_points(points) do
    points
    |> Enum.map(fn %CartesianPoint{x_offset: x, y_offset: y} -> "#{10 * x},#{1000 - 10 * y}" end)
    |> List.insert_at(0, "#{hd(points).x_offset * 10},1000")
    |> List.insert_at(-1, "#{List.last(points).x_offset * 10},1000")
    |> Enum.join(" ")
  end

  def convert_points(polar_points) do
    Enum.map(polar_points, &polar_to_cartesian/1)
  end

  def polar_to_cartesian(%PolarPoint{r: r, t: t, label: label}) do
    %CartesianPoint{
      x_offset: r * :math.cos(t),
      y_offset: r * :math.sin(t),
      label: label
    }
  end

  def angular_to_cartesian_gridlines(angles, r_max) do
    Enum.map(angles, fn t ->
      polar_to_cartesian(%PolarPoint{r: 0, t: 0}, %PolarPoint{r: r_max, t: t})
    end)
  end

  def polar_to_cartesian(%PolarPoint{} = p1, %PolarPoint{} = p2) do
    %Line{
      start: polar_to_cartesian(p1),
      end: polar_to_cartesian(p2)
    }
  end

  def polar_viewbox(%{dataset: %{axes: %{r: %{max: r_max}}}} = _chart) do
    [-r_max, -r_max, 2 * r_max, 2 * r_max]
    |> Enum.join(" ")
  end
end
