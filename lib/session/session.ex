defmodule ThemoviedbAlexa.Session do
  @moduledoc """
  Module to handle the session state for a request
  """

  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  @spec language(pid, String.t()) :: :ok
  def language(pid, language) do
    GenServer.cast(pid, {:language, language})
  end

  @spec language(pid) :: String.t()
  def language(pid) do
    GenServer.call(pid, :language)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:language, language}, state) do
    new_state = Map.put(state, :language, language)
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:language, _from, state) do
    {:reply, Map.get(state, :language), state}
  end
end
