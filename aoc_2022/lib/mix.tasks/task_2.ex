defmodule Mix.Tasks.Task2 do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    elves = %{
        A: 1, # Goes against Y(Paper)
        B: 2, # Goes against X(Rock)
        C: 3  # Goes against Z(Scissors)
      }
    me = %{
        X: 1,
        Y: 2,
        Z: 3
      }

    with stream <- File.stream!("2.txt") do
      snack_holdings =
        stream
        |> Enum.map(&String.trim/1)
        |> Enum.reduce(
          0,
          fn round, acc ->
            pair = String.split(round, " ")
            acc = acc + round_result(pair)
          end
        )
        |> IO.inspect()
    end

    with stream <- File.stream!("2.txt") do
      snack_holdings =
        stream
        |> Enum.map(&String.trim/1)
        |> Enum.reduce(
             0,
             fn round, acc ->
               pair = String.split(round, " ")
               acc = acc + round_result_scripted(pair)
             end
           )
        |> IO.inspect()
    end
  end

  def round_result(["A", "X"]), do: 3 + 1
  def round_result(["A", "Y"]), do: 6 + 2
  def round_result(["A", "Z"]), do: 0 + 3
  def round_result(["B", "X"]), do: 0 + 1
  def round_result(["B", "Y"]), do: 3 + 2
  def round_result(["B", "Z"]), do: 6 + 3
  def round_result(["C", "X"]), do: 6 + 1
  def round_result(["C", "Y"]), do: 0 + 2
  def round_result(["C", "Z"]), do: 3 + 3

  def round_result_scripted(["A", goal]) do
    case goal do
      "X" -> 0 + 3
      "Y" -> 3 + 1
      "Z" -> 6 + 2
    end
  end

  def round_result_scripted(["B", goal]) do
    case goal do
      "X" -> 0 + 1
      "Y" -> 3 + 2
      "Z" -> 6 + 3
    end
  end

  def round_result_scripted(["C", goal]) do
    case goal do
      "X" -> 0 + 2
      "Y" -> 3 + 3
      "Z" -> 6 + 1
    end
  end
end
