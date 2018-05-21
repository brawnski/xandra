defmodule Xandra.Registry do
  @moduledoc false

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def associate(name, call_options) do
    :ets.insert(__MODULE__, {name, call_options})
  end

  def lookup(name) do
    :ets.lookup_element(__MODULE__, name, 2)
  end

  def init(nil) do
    table = :ets.new(__MODULE__, [:named_table, :public, read_concurrency: true])
    {:ok, table}
  end
end
