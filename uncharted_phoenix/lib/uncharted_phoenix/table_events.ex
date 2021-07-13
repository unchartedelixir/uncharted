defmodule UnchartedPhoenix.TableEvents do
  defmacro __using__(_) do
    quote do
      def mount(socket) do
        {:ok, assign(socket, :show_table, false)}
      end

      def handle_event("show_table", _, socket) do
        {:noreply, assign(socket, :show_table, true)}
      end

      def handle_event("hide_table", _, socket) do
        {:noreply, assign(socket, :show_table, false)}
      end
    end
  end
end
