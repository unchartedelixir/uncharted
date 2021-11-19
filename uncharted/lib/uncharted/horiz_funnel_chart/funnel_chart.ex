defprotocol Uncharted.HorizontalFunnelChart do
  @spec bars(Uncharted.chart() | Uncharted.HorizontalFunnelChart.Dataset.t()) ::
          list(Uncharted.HorizontalFunnelChart.Bar.t())
  @doc """
  Returns a list of the `Uncharted.HorizontalFunnelChart.Bar.t()` that should be rendered by the chart display adapter
  """
  def bars(chart)
end
