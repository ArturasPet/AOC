defmodule Mix.Tasks.Task1 do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    with stream <- File.stream!("1.txt") do
      snack_holdings =
        stream
        |> Enum.map(&String.trim/1)
        |> Enum.chunk_by(&(&1 == ""))
        |> Enum.filter(&(&1 != [""]))
        |> Enum.map(
          fn list -> Enum.map(
            list,
            &String.to_integer/1)
          end
        )
        |> Enum.map(&Enum.sum/1)

      max_amount(snack_holdings) |> IO.inspect()
      sum_of_n_largest_amounts(snack_holdings) |> IO.inspect()
    end
  end

  def max_amount(snack_holdings), do: snack_holdings |> Enum.max()

  def sum_of_n_largest_amounts(snack_holdings) do
    snack_holdings
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.sum()
  end
end
