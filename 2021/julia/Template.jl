### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ cdce8f64-5996-11ec-00ef-77e69eb69432
begin
	using HTTP # To make HTTP requests
	using JSON # To parse JSON
	using LinearAlgebra

	using Combinatorics # To generate permutations and combinations
	using DotEnv # To load .env file
	using DataStructures # To use common data structures
	using Graphs, GraphPlot # To make and show a graph
	using IterTools # To make iteration easier
	using Mods # To use modular arithmetic
	using PlutoUI

	function get_input(year, day)
		if day == 0
			return "Set variable \$day to make this work."
		end
		
		cfg = DotEnv.config(path = "../../.env")
		session = cfg["AOC_SESSION"]
	
		r = HTTP.get("https://adventofcode.com/$year/day/$day/input", cookies=Dict("session" => session))
		return strip(String(r.body))
	end

	function submit_answer(year, day, answer, level = 1)
		if day == 0
			return "Set variable \$day to make this work."
		end
		
		cfg = DotEnv.config(path = "../../.env")
		session = cfg["AOC_SESSION"]
	
		r = HTTP.post("https://adventofcode.com/$year/day/$day/answer",
			[
			"Content-Type" => "application/x-www-form-urlencoded",
			],
			HTTP.escapeuri(Dict("level" => level, "answer" => answer)),
			cookies = Dict("session" => session))
		body = strip(String(r.body))
		return match(r"""<main>\n(.*)\n</main>""", body)[1]
	end

	md"📘 Prelude loaded. (Expand to edit dependencies.)"
end

# ╔═╡ 5a50764e-c4b8-47fd-bf5d-a307388d85f7
md"## Settings"

# ╔═╡ 96b2abc4-a7d5-4122-9c29-7136fd6ffae8
md"Year: $(@bind year NumberField(2015:2100, default=2021))"

# ╔═╡ ec70de34-7f93-4090-9132-04173fae3a3c
md"Day: $(@bind day NumberField(0:25, default=0))"

# ╔═╡ 621d1231-c6f7-4615-a81b-4a5dcb9e3405
md"""
# $(day == 0 ? "Pluto.jl Template for Advent of Code" : "Advent of Code $year: Day $day")
"""

# ╔═╡ 24b3ef81-0019-49c4-ad49-ac215826a9ac
input = get_input(year, day)

# ╔═╡ 77427f2a-c602-4dc4-a48e-2b9088fb90df
md"""
sample = $(@bind sample TextField((80, 5); default="Please paste the sample here."))
"""

# ╔═╡ 5ad03c42-119e-47ae-9b59-784d0ee97ef6
md"## Preparations"

# ╔═╡ 7d146e62-da1f-4553-a8b2-96376eb485b2
begin
	function parse_input(input::AbstractString)
		return split(input, "\n")
	end

	md"🔨 Input parser loaded. (Expand to edit.)"
end

# ╔═╡ f2cf8257-69e5-4bd7-83ce-e70d344048c4
parsed_sample = parse_input(sample)

# ╔═╡ b38281b6-7744-486a-bb65-f085ae122a80
parsed_input = parse_input(input)

# ╔═╡ e859867d-aa90-4680-a863-030f03a331ba
md"## Solutions"

# ╔═╡ f1e2cdaf-213e-411b-9c97-b218fb6bfbbc
# Common
function solve(input)
end

# ╔═╡ 84d1ee32-e4fc-4ccb-ad7a-91d359f762ba
function part_one(input)
end

# ╔═╡ cecfe041-2c83-40e1-b08e-9dda2b09656f
md"💡 Part One on sample: $(part_one(parsed_sample))"

# ╔═╡ ad6dc35a-1e71-4ff1-9264-b741d17cb42b
begin
	part_one_ans = part_one(parsed_input)
	md"🎄 Part One on input: $(part_one_ans)"
end

# ╔═╡ 067b760f-00e6-4a4b-895f-2c97017a7bcd
md"❔ Part One Correct? $(@bind part_one_correct CheckBox())"

# ╔═╡ 2700832c-7fcc-4451-a090-0dc499f5d889
part_one_correct ? submit_answer(year, day, part_one_ans) : md"❌ Part One not finished yet."

# ╔═╡ 1c325125-55e8-4174-953d-a35b85b45ba0
function part_two(input)
end

# ╔═╡ 9b2afd67-bb46-4417-8195-377c6d4eb60d
md"💡 Part Two on sample: $(part_two(parsed_sample))"

# ╔═╡ b920dad2-93fd-4a8f-980d-75c623b0c0ed
begin
	part_two_ans = part_two(parsed_input)
	md"🎄 Part Two on input: $(part_two_ans)"
end

# ╔═╡ 194ad15c-cb54-4236-a9d0-06e8c8dd8566
md"❔ Part Two Correct? $(@bind part_two_correct CheckBox())"

# ╔═╡ 0cdc8221-f4f9-4765-ad9a-5fe9e4a96e41
part_two_correct ? submit_answer(year, day, part_two_ans, 2) : md"❌ Part Two not finished yet."

# ╔═╡ 65f339b6-61b5-49af-9831-4041b9e136c8
md"""

# Notes

## Math

- Julia has internal support for extended GCD: 

  - gcdx(10, 15) = $(gcdx(10, 15))

- `Mods.jl` provides support for modular arithmetic:

  - CRT problem: (2, 1), (3, 2), (5, 3); Answer: $(CRT(Mod{2}(1), Mod{3}(2), Mod{5}(3)))

## Data Structures

`DataStructures.jl` provides common data structures:

- Deque
- Queue
- Stack
- PriorityQueue

## Iteration

`IterTools.jl` supports:

- Cartesian product: `collect(product([1, 2], [3, 4]))` = $(string(collect(product([1, 2], [3, 4]))))

`Combinatorics.jl` supports
- Permutations: `collect(permutations(1:3))` = $(string(collect(permutations(1:3))))
- Combinations: `collect(combinations(1:3, 2))` = $(string(collect(combinations(1:3, 2))))

## Graph

`Graphs.jl` and `GraphPlot.jl` provide graph utilities.

For example, we can generate a wheel graph like this:

$(gplot(wheel_graph(9)))

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Combinatorics = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
DataStructures = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
DotEnv = "4dc1fcf4-5e3b-5448-94ab-0c38ec0385c1"
GraphPlot = "a2cc645c-3eea-5389-862e-a155d0052231"
Graphs = "86223c79-3864-5bf0-83f7-82e725a168b6"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
IterTools = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Mods = "7475f97c-0381-53b1-977b-4c60186c8d62"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Combinatorics = "~1.0.2"
DataStructures = "~0.18.11"
DotEnv = "~0.3.1"
GraphPlot = "~0.5.0"
Graphs = "~1.4.1"
HTTP = "~0.9.17"
IterTools = "~1.4.0"
JSON = "~0.21.2"
Mods = "~1.3.2"
PlutoUI = "~0.7.23"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "abb72771fd8895a7ebd83d5632dc4b989b022b5b"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "f87e559f87a45bece9c9ed97458d3afe98b1ebb9"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.1.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "32a2b8af383f11cbb65803883837a149d10dfe8a"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.10.12"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Compose]]
deps = ["Base64", "Colors", "DataStructures", "Dates", "IterTools", "JSON", "LinearAlgebra", "Measures", "Printf", "Random", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "9a2695195199f4f20b94898c8a8ac72609e165a4"
uuid = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
version = "0.9.3"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DotEnv]]
git-tree-sha1 = "d48ae0052378d697f8caf0855c4df2c54a97e580"
uuid = "4dc1fcf4-5e3b-5448-94ab-0c38ec0385c1"
version = "0.3.1"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.GraphPlot]]
deps = ["ArnoldiMethod", "ColorTypes", "Colors", "Compose", "DelimitedFiles", "Graphs", "LinearAlgebra", "Random", "SparseArrays"]
git-tree-sha1 = "5e51d9d9134ebcfc556b82428521fe92f709e512"
uuid = "a2cc645c-3eea-5389-862e-a155d0052231"
version = "0.5.0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "92243c07e786ea3458532e199eb3feee0e7e08eb"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.4.1"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.Inflate]]
git-tree-sha1 = "f5fc07d4e706b84f72d54eedcc1c13d92fb0871c"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.2"

[[deps.IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.Mods]]
git-tree-sha1 = "7416683a2cc6e8c9caee75b569c993cfe34e522d"
uuid = "7475f97c-0381-53b1-977b-4c60186c8d62"
version = "1.3.2"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "d7fa6237da8004be601e19bd6666083056649918"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "5152abbdab6488d5eec6a01029ca6697dff4ec8f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.23"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "8f82019e525f4d5c669692772a6f4b0a58b06a6a"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.2.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3c76dde64d03699e074ac02eb2e8ba8254d428da"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.13"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─621d1231-c6f7-4615-a81b-4a5dcb9e3405
# ╟─cdce8f64-5996-11ec-00ef-77e69eb69432
# ╟─5a50764e-c4b8-47fd-bf5d-a307388d85f7
# ╟─96b2abc4-a7d5-4122-9c29-7136fd6ffae8
# ╟─ec70de34-7f93-4090-9132-04173fae3a3c
# ╟─24b3ef81-0019-49c4-ad49-ac215826a9ac
# ╟─77427f2a-c602-4dc4-a48e-2b9088fb90df
# ╟─5ad03c42-119e-47ae-9b59-784d0ee97ef6
# ╟─7d146e62-da1f-4553-a8b2-96376eb485b2
# ╟─f2cf8257-69e5-4bd7-83ce-e70d344048c4
# ╟─b38281b6-7744-486a-bb65-f085ae122a80
# ╟─e859867d-aa90-4680-a863-030f03a331ba
# ╠═f1e2cdaf-213e-411b-9c97-b218fb6bfbbc
# ╠═84d1ee32-e4fc-4ccb-ad7a-91d359f762ba
# ╟─cecfe041-2c83-40e1-b08e-9dda2b09656f
# ╟─ad6dc35a-1e71-4ff1-9264-b741d17cb42b
# ╟─067b760f-00e6-4a4b-895f-2c97017a7bcd
# ╟─2700832c-7fcc-4451-a090-0dc499f5d889
# ╠═1c325125-55e8-4174-953d-a35b85b45ba0
# ╟─9b2afd67-bb46-4417-8195-377c6d4eb60d
# ╟─b920dad2-93fd-4a8f-980d-75c623b0c0ed
# ╟─194ad15c-cb54-4236-a9d0-06e8c8dd8566
# ╟─0cdc8221-f4f9-4765-ad9a-5fe9e4a96e41
# ╟─65f339b6-61b5-49af-9831-4041b9e136c8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
