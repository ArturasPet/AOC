defmodule Mix.Tasks.Task3 do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    with stream <- File.stream!("3.txt") do
      stream
      |> Enum.map(&String.trim/1)
      |> Enum.reduce(0, fn rucksack_contents, acc ->
        String.graphemes(rucksack_contents) |> IO.inspect()
        acc + 1
      end)
    end
  end
end
