defmodule Uncharted.StackedColumnChartTest do
  alias Uncharted.{
    BaseChart,
    BaseDatum,
    StackedColumnChart
  }

  alias Uncharted.Axes.{BaseAxes, MagnitudeAxis}
  use ExUnit.Case

  @y_axis %MagnitudeAxis{min: 0, max: 2500}
  @axes %BaseAxes{magnitude_axis: @y_axis}
  @data [
    %BaseDatum{name: "Bar One", values: [550, 200]},
    %BaseDatum{name: "Bar Two", values: [1000, 100]},
    %BaseDatum{name: "Bar Three", values: [2400, 100]},
    %BaseDatum{name: "Bar Four", values: [750]},
    %BaseDatum{name: "Bar Five", values: [1650, 100]}
  ]
  @sections [
    %StackedColumnChart.Section{fill_color: "blue", label: "Section 2", index: 1},
    %StackedColumnChart.Section{fill_color: "blue", label: "Section 1", index: 0}
  ]
  @dataset %StackedColumnChart.Dataset{data: @data, axes: @axes, sections: @sections}
  @chart %BaseChart{title: "title", dataset: @dataset}

  describe "columns/1" do
    test "returns the number of columns that make up the dataset" do
      assert length(StackedColumnChart.columns(@chart)) == length(@data)
    end

    test "returns column labels" do
      columns = Enum.map(StackedColumnChart.columns(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert columns
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "returns evenly distributed column widths" do
      column_widths = Enum.map(StackedColumnChart.columns(@chart), & &1.width)
      expected_column_width = 20.0

      assert Enum.all?(column_widths, fn column_width -> column_width == expected_column_width end)
    end

    test "returns bar widths as half of column widths" do
      bar_widths = Enum.map(StackedColumnChart.columns(@chart), & &1.bar_width)
      expected_bar_width = 10.0

      assert Enum.all?(bar_widths, fn bar_width -> bar_width == expected_bar_width end)
    end

    test "returns correct column offsets" do
      column_offsets = Enum.map(StackedColumnChart.columns(@chart), & &1.offset)
      expected_column_offsets = [0.0, 20.0, 40.0, 60.0, 80.0]

      assert column_offsets == expected_column_offsets
    end

    test "returns bar_offsets with margins taken into account" do
      bar_offsets = Enum.map(StackedColumnChart.columns(@chart), & &1.bar_offset)
      expected_bar_offsets = [5.0, 25.0, 45.0, 65.0, 85.0]

      assert bar_offsets == expected_bar_offsets
    end

    test "returns proper number of column sections" do
      section_count = @chart
      |> StackedColumnChart.columns()
      |> Enum.reduce(0, fn %StackedColumnChart.Column{sections: sections}, acc -> Enum.count(sections) + acc end)

      assert section_count == 9
    end

    test "calculates column section height as a percent of y-axis max value" do
      section_heights = @chart
      |> StackedColumnChart.columns()
      |> Enum.flat_map(fn %StackedColumnChart.Column{sections: sections} -> Enum.map(sections, & &1.column_height) end)
      expected_section_heights = [22.0, 8.0, 40.0, 4.0, 96.0, 4.0, 30.0, 66.0, 4.0]

      assert section_heights == expected_section_heights
    end

    test "calculates column section offsets based on full column height" do
      section_offsets = @chart
      |> StackedColumnChart.columns()
      |> Enum.flat_map(fn %StackedColumnChart.Column{sections: sections} -> Enum.map(sections, & &1.offset) end)
      expected_offsets = [30.0, 8.0, 44.0, 4.0, 100.0, 4.0, 30.0, 70.0, 4.0]

      assert section_offsets == expected_offsets
    end
  end
end
