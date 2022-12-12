defmodule Mix.Tasks.Task3 do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    alphabet_lower = ?a..?z |> Enum.to_list() |> List.to_string() |> String.graphemes()
    alphabet_upper = ?A..?Z |> Enum.to_list() |> List.to_string() |> String.graphemes()
    alphabet = alphabet_lower ++ alphabet_upper
    # priority =  Enum.find_index(alphabet) + 1

    with stream <- File.stream!("3.txt") do
      stream
      |> Enum.map(&String.trim/1)
      |> Enum.reduce(0, fn rucksack_contents, acc ->
        char_list = String.graphemes(rucksack_contents)
        char_count = div(Enum.count(char_list), 2)
        [left | right] = Enum.chunk_every(char_list, char_count)
        left = Enum.uniq(left)
        right =
          right
          |> List.flatten()
          |> Enum.uniq()
        diff = left -- List.flatten(right)
        [common_item] = left -- diff
        priority = Enum.find_index(alphabet, fn letter -> letter == common_item end) + 1
        acc + priority
      end)
      |> IO.inspect()
    end

    with stream <- File.stream!("3.txt") do
      stream
      |> Enum.map(&String.trim/1)
      |> Enum.chunk_every(3)
      |> Enum.reduce(0, fn group_of_three, acc ->
        diff1 = (Enum.at(group_of_three, 0) |> String.graphemes()) -- (Enum.at(group_of_three, 1) |> String.graphemes())
        diff2 = (Enum.at(group_of_three, 0) |> String.graphemes()) -- (Enum.at(group_of_three, 2) |> String.graphemes())
        common_elems = (Enum.at(group_of_three, 0) |> String.graphemes()) -- diff1 # |> IO.inspect()
        # [common_item] = common_elems -- diff2 |> Enum.uniq() |> IO.inspect()
        case (common_elems -- diff2) |> Enum.uniq() do
          [] -> acc
          [common_item] ->
            priority = Enum.find_index(alphabet, fn letter -> letter == common_item end) + 1
            acc + priority
        end
      end)
      |> IO.inspect()
    end
  end
end
