defmodule Uncharted.ScatterPlotTest do
  alias Uncharted.{BaseChart, BaseDatum, ScatterPlot}
  alias Uncharted.Axes.{MagnitudeAxis, XYAxes}
  alias Uncharted.ScatterPlot.Dataset
  use ExUnit.Case

  @x_axis %MagnitudeAxis{min: 0, max: 10}
  @y_axis %MagnitudeAxis{min: -500, max: 2500}
  @axes %XYAxes{x: @x_axis, y: @y_axis}
  @data [
    %BaseDatum{name: "Point One", values: [1, 750, 9]},
    %BaseDatum{name: "Point Two", values: [5, 1500]},
    %BaseDatum{name: "Point Three", values: [6, 2250]},
    %BaseDatum{name: "Point Four", values: [8, 600]},
    %BaseDatum{name: "Point Five", values: [10, 1200]}
  ]
  @dataset %Dataset{data: @data, axes: @axes}
  @chart %BaseChart{title: "title", dataset: @dataset}

  describe "points/1" do
    test "returns the number of points that make up the dataset" do
      assert length(ScatterPlot.points(@chart)) == length(@data)
    end

    test "returns point radius" do
      [radius_9 | points] = ScatterPlot.points(@chart)
      assert radius_9.radius == 9
      Enum.each(points, fn point -> assert point.radius == 6 end)
    end

    test "returns point labels" do
      points = Enum.map(ScatterPlot.points(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert points
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "calculates point x value as a percent of x-axis min and max value" do
      x_offsets = Enum.map(ScatterPlot.points(@chart), & &1.x_offset)
      expected_x_offsets = [10.0, 50.0, 60.0, 80.0, 100.0]

      assert x_offsets == expected_x_offsets
    end

    test "calculates point y value as a percent of y-axis min and max value" do
      y_offsets = Enum.map(ScatterPlot.points(@chart), & &1.y_offset)
      expected_y_offsets = [25.0, 50.0, 75.0, 20.0, 40.0]

      assert y_offsets == expected_y_offsets
    end
  end
end
