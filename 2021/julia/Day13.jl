### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ cdce8f64-5996-11ec-00ef-77e69eb69432
using HTTP, DotEnv, PlutoUI

# ╔═╡ 96b2abc4-a7d5-4122-9c29-7136fd6ffae8
year = 2021

# ╔═╡ ec70de34-7f93-4090-9132-04173fae3a3c
day = 13

# ╔═╡ 790ebff9-98f3-49a3-9232-08ca3113bed6
function get_input()
	cfg = DotEnv.config(path = "../../.env")
	session = cfg["AOC_SESSION"]

	r = HTTP.get("https://adventofcode.com/$year/day/$day/input", cookies=Dict("session" => session))
	return strip(String(r.body))
end

# ╔═╡ 24b3ef81-0019-49c4-ad49-ac215826a9ac
input = get_input()

# ╔═╡ 77427f2a-c602-4dc4-a48e-2b9088fb90df
sample = """6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5"""

# ╔═╡ 84d1ee32-e4fc-4ccb-ad7a-91d359f762ba
function part_one(input)
	s = Set()
	for line in split(input, "\n")
		if length(line) == 0
			continue
		end

		if line[1] == 'f'
			m = parse(Int, split(line, "=")[2])
			if line[12] == 'x'
				s = Set(map(x -> (x[1] < m ? x[1] : 2m - x[1], x[2]), collect(s)))
			else
				s = Set(map(x -> (x[1], x[2] < m ? x[2] : 2m - x[2]), collect(s)))
			end

			return length(s)
		else
			x, y = map(it -> parse(Int, it), split(line, ","))
			push!(s, (x, y))
		end
	end
end

# ╔═╡ cecfe041-2c83-40e1-b08e-9dda2b09656f
part_one(sample)

# ╔═╡ ad6dc35a-1e71-4ff1-9264-b741d17cb42b
part_one(input)

# ╔═╡ 1c325125-55e8-4174-953d-a35b85b45ba0
function part_two(input)
	s = Set()
	for line in split(input, "\n")
		if length(line) == 0
			continue
		end

		if line[1] == 'f'
			m = parse(Int, split(line, "=")[2])
			if line[12] == 'x'
				s = Set(map(x -> (x[1] < m ? x[1] : 2m - x[1], x[2]), collect(s)))
			else
				s = Set(map(x -> (x[1], x[2] < m ? x[2] : 2m - x[2]), collect(s)))
			end
		else
			x, y = map(it -> parse(Int, it), split(line, ","))
			push!(s, (x, y))
		end
	end

	max_x = maximum(x[1] for x in s)
	max_y = maximum(x[2] for x in s)	

	with_terminal() do
		for y in 0:max_y
			println(join((x, y) ∈ s ? '#' : '.' for x in 0:max_x))
		end
	end
end

# ╔═╡ 9b2afd67-bb46-4417-8195-377c6d4eb60d
part_two(sample)

# ╔═╡ b920dad2-93fd-4a8f-980d-75c623b0c0ed
part_two(input)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DotEnv = "4dc1fcf4-5e3b-5448-94ab-0c38ec0385c1"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DotEnv = "~0.3.1"
HTTP = "~0.9.17"
PlutoUI = "~0.7.22"
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

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DotEnv]]
git-tree-sha1 = "d48ae0052378d697f8caf0855c4df2c54a97e580"
uuid = "4dc1fcf4-5e3b-5448-94ab-0c38ec0385c1"
version = "0.3.1"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

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

[[deps.IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

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

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "565564f615ba8c4e4f40f5d29784aa50a8f7bbaf"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.22"

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

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

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

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═cdce8f64-5996-11ec-00ef-77e69eb69432
# ╠═96b2abc4-a7d5-4122-9c29-7136fd6ffae8
# ╠═ec70de34-7f93-4090-9132-04173fae3a3c
# ╠═790ebff9-98f3-49a3-9232-08ca3113bed6
# ╠═24b3ef81-0019-49c4-ad49-ac215826a9ac
# ╠═77427f2a-c602-4dc4-a48e-2b9088fb90df
# ╠═84d1ee32-e4fc-4ccb-ad7a-91d359f762ba
# ╠═cecfe041-2c83-40e1-b08e-9dda2b09656f
# ╠═ad6dc35a-1e71-4ff1-9264-b741d17cb42b
# ╠═1c325125-55e8-4174-953d-a35b85b45ba0
# ╠═9b2afd67-bb46-4417-8195-377c6d4eb60d
# ╠═b920dad2-93fd-4a8f-980d-75c623b0c0ed
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
