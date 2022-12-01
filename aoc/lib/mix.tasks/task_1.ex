defmodule Mix.Tasks.Task1 do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    with stream <- File.stream!("1.txt") do
      stream
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)
      |> IO.inspect()
    end

    # with {:ok, contents} <- File.read("1.txt") do
    #   contents |> String.split("\r\n") |> IO.inspect()
    #   # contents
    #   # |> String.split("\n", trim: true)
    #   # |> String.trim()
    #   # |> IO.inspect()
    # end
  end

end
