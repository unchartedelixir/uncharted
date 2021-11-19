defmodule Uncharted.HorizontalFunnelChartTest do
  alias Uncharted.{BaseChart, BaseDatum, HorizontalFunnelChart}
  alias Uncharted.Axes.{BaseAxes, MagnitudeAxis}

  use ExUnit.Case

  @x_axis %MagnitudeAxis{min: 0, max: 3000}
  @axes %BaseAxes{magnitude_axis: @x_axis}
  @data [
    %BaseDatum{name: "Bar Three", values: [3000]},
    %BaseDatum{name: "Bar Four", values: [1500, 750]},
    %BaseDatum{name: "Bar Five", values: [1750]},
    %BaseDatum{name: "Bar One", values: [750, 750]},
    %BaseDatum{name: "Bar Two", values: [1500]}
  ]
  @sections [
    %Uncharted.Section{fill_color: "blue", label: "Section 2", index: 1},
    %Uncharted.Section{fill_color: "blue", label: "Section 1", index: 0}
  ]
  @dataset %HorizontalFunnelChart.Dataset{data: @data, sections: @sections, axes: @axes}
  @chart %BaseChart{title: "title", dataset: @dataset, height: 1000, width: 100}

  describe "bars/1" do
    test "returns the number of bars that make up the dataset" do
      assert length(HorizontalFunnelChart.bars(@chart)) == length(@data)
    end

    test "returns bar labels" do
      bars = Enum.map(HorizontalFunnelChart.bars(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert bars
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "returns evenly distributed bar widths" do
      bar_widths = Enum.map(HorizontalFunnelChart.bars(@chart), & &1.width)
      expected_bar_width = 20.0

      assert Enum.all?(bar_widths, fn bar_width -> bar_width == expected_bar_width end)
    end

    test "returns correct bar heights" do
      column_offsets = Enum.map(HorizontalFunnelChart.bars(@chart), & &1.offset)
      expected_column_offsets = [0.0, 20.0, 40.0, 60.0, 80.0]

      assert column_offsets == expected_column_offsets
    end

    test "returns y points with margins taken into account" do
      y_points =
        Enum.flat_map(HorizontalFunnelChart.bars(@chart), fn %HorizontalFunnelChart.Bar{
                                                               sections: sections
                                                             } ->
          Enum.map(sections, & &1.y_points)
        end)

      expected_y_points = [
        [0.0, 768.0, 480.0, 96.0],
        [96.0, 480.0, 608.0, 160.0],
        [480.0, 672.0, 608.0, 608.0],
        [160.0, 608.0, 384.0, 192.0],
        [192.0, 384.0, 576.0, 192.0],
        [384.0, 576.0, 576.0, 576.0],
        [192.0, 576.0, 576.0, 192.0]
      ]

      assert y_points == expected_y_points
    end

    test "returns x points with no margins" do
      x_points =
        Enum.flat_map(HorizontalFunnelChart.bars(@chart), fn %HorizontalFunnelChart.Bar{
                                                               sections: sections
                                                             } ->
          Enum.map(sections, & &1.x_points)
        end)

      expected_x_points = [
        [0.0, 9.2, 18.4],
        [18.4, 27.6, 36.8],
        [18.4, 27.6, 36.8],
        [36.8, 46.0, 55.2],
        [55.2, 64.4, 73.6],
        [55.2, 64.4, 73.6],
        [73.6, 82.8, 92.0]
      ]

      assert x_points == expected_x_points
    end

    test "returns proper number of bar sections" do
      section_count =
        @chart
        |> HorizontalFunnelChart.bars()
        |> Enum.reduce(0, fn %HorizontalFunnelChart.Bar{sections: sections}, acc ->
          Enum.count(sections) + acc
        end)

      assert section_count == 7
    end

    test "calculates bar section width as a percent of y-axis max value" do
      section_heights =
        @chart
        |> HorizontalFunnelChart.bars()
        |> Enum.flat_map(fn %HorizontalFunnelChart.Bar{sections: sections} ->
          Enum.map(sections, & &1.bar_height)
        end)

      expected_section_heights = [100.0, 50.0, 25.0, 58.333333333333336, 25.0, 25.0, 50.0]

      assert section_heights == expected_section_heights
    end

    test "calculates bar offsets based on full bar height" do
      section_offsets =
        @chart
        |> HorizontalFunnelChart.bars()
        |> Enum.map(& &1.offset)

      expected_offsets = [0.0, 20.0, 40.0, 60.0, 80.0]

      assert section_offsets == expected_offsets
    end
  end
end
