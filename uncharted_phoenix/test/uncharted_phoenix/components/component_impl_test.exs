defmodule UnchartedPhoenix.ComponentImplTest do
  alias Uncharted.BarChart.Dataset
  alias Uncharted.BaseChart
  alias Uncharted.Component
  use ExUnit.Case

  @base_chart %BaseChart{dataset: %Dataset{data: []}}
  @custom_id "my-custom-id"

  describe "Uncharted.Component impl for Uncharted.BaseChart" do
    test "returns the dataset's module name as ID" do
      assert Component.id(@base_chart) == "Uncharted.BarChart.Dataset"
    end

    test "allows users to override the default ID by adding component_id to BaseChart" do
      assert Component.id(%BaseChart{@base_chart | component_id: @custom_id}) ==
               "Uncharted.BarChart.Dataset__#{@custom_id}"
    end
  end
end
