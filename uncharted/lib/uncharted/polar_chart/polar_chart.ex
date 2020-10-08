defprotocol Uncharted.PolarChart do
  @spec points(Uncharted.chart() | Uncharted.PolarChart.Dataset.t()) ::
          list(Uncharted.PolarChart.Point.t())
  def points(chart)
end
