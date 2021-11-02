defimpl Uncharted.Component, for: Uncharted.BaseChart do
  alias Uncharted.BaseChart

  @components ~w(Bar Column Doughnut Funnel HorizontalFunnel Line Pie Progress Scatter)

  def for_dataset(%BaseChart{dataset: dataset}) do
    if is_map(dataset) do
      dataset_type = chart_name(Atom.to_string(dataset.__struct__))

      if dataset_type in @components do
        "Elixir.UnchartedPhoenix.Live#{dataset_type}Component" |> String.to_existing_atom()
      else
        no_component(dataset)
      end
    else
      no_component(dataset)
    end
  end

  def id(%BaseChart{component_id: nil, dataset: dataset}) do
    strip_prefix(Atom.to_string(dataset.__struct__))
  end

  def id(%BaseChart{component_id: id, dataset: dataset}) when is_binary(id) do
    strip_prefix(Atom.to_string(dataset.__struct__) <> "__" <> id)
  end

  def id(%BaseChart{component_id: id, dataset: dataset}) when is_number(id) do
    strip_prefix(Atom.to_string(dataset.__struct__) <> "__" <> "#{id}")
  end

  def error_message(dataset) do
    """
    No UnchartedPhoenix Component defined for dataset: #{inspect(dataset)}.
    To define your own Component, implement the Uncharted.Component protocol for your own chart and datasets.
    """
  end

  defp strip_prefix(id) do
    String.replace(id, "Elixir.", "")
  end

  defp chart_name(struct_name) do
    String.replace(struct_name, ~r/Elixir.Uncharted.|Plot|Chart|.Dataset/, "")
  end

  defp no_component(dataset) do
    raise UnchartedPhoenix.ComponentUndefinedError, message: error_message(dataset)
  end
end
