defprotocol Uncharted.FunnelChart do
  @spec bars(Uncharted.chart() | Uncharted.FunnelChart.Dataset.t()) ::
          list(Uncharted.FunnelChart.Bar.t())
  @doc """
  Returns a list of the `Uncharted.FunnelChart.Bar.t()` that should be rendered by the chart display adapter
  """
  def bars(chart)
end
