defmodule Mix.Tasks.Task4 do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    with stream <- File.stream!("4.txt") do
      stream
      |> Enum.map(&String.trim/1)
      |> Enum.map(fn pair ->
        ranges = String.split(pair, ",")# |> IO.inspect()
        |> Enum.map(fn bounds ->
          lower_bound = String.split(bounds, "-") |> List.first() |> String.to_integer()# |> IO.inspect()
          upper_bound = String.split(bounds, "-") |> List.last() |> String.to_integer()# |> IO.inspect()
          Enum.to_list(lower_bound..upper_bound)
        end)
        IO.inspect(ranges)
        MapSet.subset?(MapSet.new(List.first(ranges)), MapSet.new(List.last(ranges)))# |> IO.inspect()
      end)
      # |> IO.inspect()
    end
  end
end
