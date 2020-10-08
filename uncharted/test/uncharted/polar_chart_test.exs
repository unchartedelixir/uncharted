defmodule Uncharted.PolarChartTest do
  alias Uncharted.{BaseChart, BaseDatum, PolarChart}
  alias Uncharted.Axes.{MagnitudeAxis, PolarAxes}
  alias Uncharted.PolarChart.Dataset
  alias Uncharted.PolarChart.Line
  use ExUnit.Case

  @radial_axis %MagnitudeAxis{min: 0, max: 12.0}
  @angular_axis %MagnitudeAxis{min: 0, max: 2.0, units: :radians, step: 4}
  @axes %PolarAxes{r: @radial_axis, t: @angular_axis}
  @data [
    %BaseDatum{name: "Point One", values: [1, 1.3]},
    %BaseDatum{name: "Point Two", values: [5, 1.0]},
    %BaseDatum{name: "Point Three", values: [6, 0.5]},
    %BaseDatum{name: "Point Four", values: [8, 1.8]},
    %BaseDatum{name: "Point Five", values: [10, 0.3]}
  ]
  @dataset %Dataset{data: @data, axes: @axes}
  @chart %BaseChart{title: "title", dataset: @dataset}

  describe "points/1" do
    test "returns the number of points that make up the dataset" do
      assert length(PolarChart.points(@chart)) == length(@data)
    end

    test "returns point labels" do
      points = Enum.map(PolarChart.points(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert points
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "assigns point r (radial distance) value as first element in datum.values" do
      r_values = Enum.map(PolarChart.points(@chart), & &1.r)
      expected_r_values = [1, 5, 6, 8, 10]

      assert r_values == expected_r_values
    end

    test "assigns point t (angular distance) value as first element in datum.values" do
      t_values = Enum.map(PolarChart.points(@chart), & &1.t)
      expected_t_values = [1.3, 1.0, 0.5, 1.8, 0.3]

      assert t_values == expected_t_values
    end
  end
end
