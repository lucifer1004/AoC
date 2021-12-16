### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ cdce8f64-5996-11ec-00ef-77e69eb69432
using HTTP, DotEnv

# ╔═╡ 96b2abc4-a7d5-4122-9c29-7136fd6ffae8
year = 2021

# ╔═╡ ec70de34-7f93-4090-9132-04173fae3a3c
day = 16

# ╔═╡ 790ebff9-98f3-49a3-9232-08ca3113bed6
function get_input()
	cfg = DotEnv.config(path = "../../.env")
	session = cfg["AOC_SESSION"]

	r = HTTP.get("https://adventofcode.com/$year/day/$day/input", cookies=Dict("session" => session))
	return string(strip(String(r.body)))
end

# ╔═╡ 24b3ef81-0019-49c4-ad49-ac215826a9ac
input = get_input()

# ╔═╡ 77427f2a-c602-4dc4-a48e-2b9088fb90df
sample = """D2FE28"""

# ╔═╡ 6228e3df-af33-4cbb-a46c-076821c7c96b
begin
	@enum ExpressionType SUM PROD MIN MAX LIT GT LT EQ
	
	struct Expression
		version::Int64
		itype::ExpressionType
		length::Int64
		value::Int64
		children::Vector{Expression}
	end

	function Expression(hex::String)
		bits = join(map(x -> 
			lpad(string(parse(Int, string(x), base=16), base=2), 4, '0'),
			collect(hex)))

		return Expression(bits, 0)
	end

	function Expression(bits::String, offset::Int64)
		version = parse(Int, bits[offset+1:offset+3], base=2)
		itype = ExpressionType(parse(Int, bits[offset+4:offset+6], base=2))
		children = Expression[]
		ptr = offset + 7
		
		if itype == LIT
			value = 0
			while bits[ptr] == '1'
				value = value * 16 + parse(Int, bits[ptr+1:ptr+4], base=2)
				ptr += 5
			end
			value = value * 16 + parse(Int, bits[ptr+1:ptr+4], base=2)
			ptr += 4

			return Expression(version, itype, ptr - offset, value, children)
		else
			if bits[ptr] == '0'
				sub_length = parse(Int, bits[ptr+1:ptr+15], base=2)
				ptr += 15
				while ptr < offset + 22 + sub_length
					child = Expression(bits, ptr)
					push!(children, child)
					ptr += child.length
				end
			else
				sub_count = parse(Int, bits[ptr+1:ptr+11], base=2)
				ptr += 11
				for _ in 1:sub_count
					child = Expression(bits, ptr)
					push!(children, child)
					ptr += child.length
				end
			end

			values = map(x -> x.value, children)

			if itype == SUM
				value = sum(values)
			elseif itype == PROD
				value = prod(values)
			elseif itype == MIN
				value = minimum(values)
			elseif itype == MAX
				value = maximum(values)
			elseif itype == GT
				value = values[1] > values[2] ? 1 : 0
			elseif itype == LT
				value = values[1] < values[2] ? 1 : 0
			else
				value = values[1] == values[2] ? 1 : 0
			end

			return Expression(version, itype, ptr - offset, value, children)
		end
	end

	Base.show(io::IO, exp::Expression) = begin
		if exp.itype == LIT
			print(io, exp.value)
		else
			print(io, '(')
			print(io, ["+", "*", "min", "max", "", ">", "<", "="][Int(exp.itype) + 1])
			print(io, ' ')
			for (i, sub_exp) in enumerate(exp.children)
				Base.show(io, sub_exp)
				if i != length(exp.children)
					print(io, ' ')
				end
			end
			print(io, ')')
		end
	end
end

# ╔═╡ 174cf007-1f4f-4e47-91c9-00deb46666d5
Expression(sample)

# ╔═╡ 5816bf75-fa88-483f-a9de-5934a92e1c31
Expression(input)

# ╔═╡ 84d1ee32-e4fc-4ccb-ad7a-91d359f762ba
function part_one(input)
	exp = Expression(input)
	version_sum = 0

	function dfs(exp::Expression)
		version_sum += exp.version
		for sub_exp in exp.children
			dfs(sub_exp)
		end
	end

	dfs(exp)
	return version_sum
end

# ╔═╡ cecfe041-2c83-40e1-b08e-9dda2b09656f
part_one(sample)

# ╔═╡ ad6dc35a-1e71-4ff1-9264-b741d17cb42b
part_one(input)

# ╔═╡ 1c325125-55e8-4174-953d-a35b85b45ba0
function part_two(input)
	exp = Expression(input)
	return exp.value
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

[compat]
DotEnv = "~0.3.1"
HTTP = "~0.9.17"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

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

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╠═cdce8f64-5996-11ec-00ef-77e69eb69432
# ╠═96b2abc4-a7d5-4122-9c29-7136fd6ffae8
# ╠═ec70de34-7f93-4090-9132-04173fae3a3c
# ╠═790ebff9-98f3-49a3-9232-08ca3113bed6
# ╠═24b3ef81-0019-49c4-ad49-ac215826a9ac
# ╠═77427f2a-c602-4dc4-a48e-2b9088fb90df
# ╠═6228e3df-af33-4cbb-a46c-076821c7c96b
# ╠═174cf007-1f4f-4e47-91c9-00deb46666d5
# ╠═5816bf75-fa88-483f-a9de-5934a92e1c31
# ╠═84d1ee32-e4fc-4ccb-ad7a-91d359f762ba
# ╠═cecfe041-2c83-40e1-b08e-9dda2b09656f
# ╠═ad6dc35a-1e71-4ff1-9264-b741d17cb42b
# ╠═1c325125-55e8-4174-953d-a35b85b45ba0
# ╠═9b2afd67-bb46-4417-8195-377c6d4eb60d
# ╠═b920dad2-93fd-4a8f-980d-75c623b0c0ed
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
