defprotocol Uncharted.Dataset do
  @doc """
  Takes an `Uncharted.dataset` data structure
  and returns a label for the data names. This label
  will be used as the first header of the data table
  provided for accessibilty.
  """
  @fallback_to_any true
  @spec data_name_label(Uncharted.dataset()) :: String.t()
  def data_name_label(dataset)

  @doc """
  Takes an `Uncharted.dataset` data structure
  and returns a label for the data values. This label
  will be used as the second header of the data table
  provided for accessibilty.
  """
  @fallback_to_any true
  @spec data_value_label(Uncharted.dataset()) :: String.t()
  def data_value_label(dataset)
end

defimpl Uncharted.Dataset, for: Any do
  def data_name_label(_), do: "Data Names"
  def data_value_label(_), do: "Data Values"
end
