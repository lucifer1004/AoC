defmodule AoC do
  def count_nums([], map), do: map

  def count_nums([num | rest], map) do
    case Map.has_key?(map, num) do
      true ->
        map = Map.update!(map, num, fn val -> val + 1 end)
        count_nums(rest, map)

      false ->
        map = Map.put_new(map, num, 1)
        count_nums(rest, map)
    end
  end

  def find_complement(num, target, map) do
    case Map.has_key?(map, target - num) do
      true ->
        case target == 2 * num and Map.get(map, num) < 2 do
          true -> -1
          false -> num * (target - num)
        end

      false ->
        -1
    end
  end

  def choose_three(nums) do
    if length(nums) < 3 do
      []
    else
      lst = [[]]

      choose_three(nums, lst)
      |> Enum.filter(fn x -> length(x) == 3 end)
    end
  end

  defp choose_three(nums, lst) do
    if length(nums) == 0 do
      lst
    else
      [head | tail] = nums

      append =
        lst
        |> Enum.filter(fn x -> length(x) < 3 end)
        |> Enum.map(fn x -> [head | x] end)

      choose_three(tail, lst ++ append)
    end
  end
end

{:ok, contents} = File.read("input.txt")

nums =
  contents
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.to_list()

nums_map = AoC.count_nums(nums, Map.new())

target = 2020

# Part I

ans =
  nums
  |> Enum.map(fn x -> AoC.find_complement(x, target, nums_map) end)
  |> Enum.filter(fn x -> x > 0 end)

if length(ans) > 0 do
  IO.puts(List.first(ans))
end

# Part II (Brute force)
AoC.choose_three(nums)
|> Enum.each(fn comb ->
  [x, y, z] = comb

  if x + y + z == target do
    IO.puts(x * y * z)
  end
end)
