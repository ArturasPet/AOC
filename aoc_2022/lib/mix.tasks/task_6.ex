defmodule Mix.Tasks.Task6 do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    with {:ok, content} <- File.read("6.txt") do
      IO.puts("Start-of-packet position:")
      content
      |> String.graphemes()
      |> check_if_marker(4)
      IO.puts("Start-of-message position:")
      content
      |> String.graphemes()
      |> check_if_marker(14)
    end
  end

  def check_if_marker(list, marker_length), do:
    check_if_marker(list, marker_length, marker_length)

  def check_if_marker(list, acc, marker_length) do
    maybe_marker =
      Enum.take(list, marker_length)
      |> Enum.uniq()

    case maybe_marker == Enum.take(list, marker_length) do
      true -> IO.inspect(acc)
      false -> check_if_marker(Enum.drop(list, 1), acc + 1, marker_length)
    end
  end
end
