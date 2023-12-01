defmodule Mix.Tasks.Task11 do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    with stream <- File.stream!("11.txt") do
      stream
      |> Enum.map(&String.trim/1)
      |> Enum.chunk_every(6, 7)
      |> IO.inspect()
      |> Enum.map(fn data -> parse_monkey_data(data) end)
    end
  end

  def parse_monkey_data(data) do
    # First line: Monkey ID
    [_ | [id_string]] = Enum.at(data, 0) |> String.split()
    monkey_id =
      String.replace_trailing(id_string, ":", "")
      |> String.to_integer()

    # Second line: Starting items
    items =
      Enum.at(data, 1)
      |> String.replace_prefix("Starting items: ", "")
      |> String.split(", ")
      |> Enum.map(fn n ->
        {n, _} = Integer.parse(n)
        n
      end)
      |> IO.inspect()

    # [
    #   one: Enum.at(data, 0),
    #   monkey_id: Enum.at(0) |> String.split()
    #   two: Enum.at(data, 1),
    #   three: Enum.at(data, 2),
    #   four: Enum.at(data, 3),
    #   five: Enum.at(data, 4),
    #   six: Enum.at(data, 5)
    # ]
    # |> Map.new()
    # |> IO.inspect()
  end
end
