defprotocol Uncharted.StackedColumnChart do
  @spec columns(Uncharted.chart() | Uncharted.StackedColumnChart.Dataset.t()) ::
          list(Uncharted.StackedColumnChart.Column.t())
  def columns(chart)
end
