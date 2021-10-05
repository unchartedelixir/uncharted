defprotocol Uncharted.ScatterPlot do
  @spec points(Uncharted.chart() | Uncharted.ScatterPlot.Dataset.t()) ::
          list(Uncharted.ScatterPlot.Point.t())
  def points(chart)
end
