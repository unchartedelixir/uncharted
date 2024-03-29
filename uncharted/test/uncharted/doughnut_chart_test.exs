defmodule Uncharted.DoughnutChartTest do
  alias Uncharted.{
    BaseChart,
    BaseDatum,
    DoughnutChart
  }

  use ExUnit.Case

  @data [
    %BaseDatum{name: "Slice One", values: [20.0]},
    %BaseDatum{name: "Slice Two", values: [24.0]},
    %BaseDatum{name: "Slice Three", values: [27.0]},
    %BaseDatum{name: "Slice Four", values: [7.0]},
    %BaseDatum{name: "Slice Five", values: [22.0]}
  ]
  @dataset %DoughnutChart.Dataset{data: @data}
  @chart %BaseChart{title: "title", dataset: @dataset}

  describe "doughnut_slices/1" do
    test "returns the number of slices that make up the dataset" do
      assert length(DoughnutChart.doughnut_slices(@chart)) == length(@data)
    end

    test "returns doughnut slice labels" do
      doughnut_slices = Enum.map(DoughnutChart.doughnut_slices(@chart), & &1.label)
      labels = Enum.map(@data, & &1.name)

      assert doughnut_slices
             |> Enum.zip(labels)
             |> Enum.all?(fn {actual, expected} -> actual == expected end)
    end

    test "returns correct percentages for slices" do
      doughnut_slice_percentages =
        Enum.map(DoughnutChart.doughnut_slices(@chart), & &1.percentage)

      expected_percentages = [20.0, 24.0, 27.0, 7.0, 22.0]

      assert doughnut_slice_percentages == expected_percentages
    end
  end
end
