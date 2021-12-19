### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ cdce8f64-5996-11ec-00ef-77e69eb69432
using HTTP, DotEnv, Combinatorics, IterTools

# ╔═╡ 96b2abc4-a7d5-4122-9c29-7136fd6ffae8
year = 2021

# ╔═╡ ec70de34-7f93-4090-9132-04173fae3a3c
day = 19

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
sample = """--- scanner 0 ---
404,-588,-901
528,-643,409
-838,591,734
390,-675,-793
-537,-823,-458
-485,-357,347
-345,-311,381
-661,-816,-575
-876,649,763
-618,-824,-621
553,345,-567
474,580,667
-447,-329,318
-584,868,-557
544,-627,-890
564,392,-477
455,729,728
-892,524,684
-689,845,-530
423,-701,434
7,-33,-71
630,319,-379
443,580,662
-789,900,-551
459,-707,401

--- scanner 1 ---
686,422,578
605,423,415
515,917,-361
-336,658,858
95,138,22
-476,619,847
-340,-569,-846
567,-361,727
-460,603,-452
669,-402,600
729,430,532
-500,-761,534
-322,571,750
-466,-666,-811
-429,-592,574
-355,545,-477
703,-491,-529
-328,-685,520
413,935,-424
-391,539,-444
586,-435,557
-364,-763,-893
807,-499,-711
755,-354,-619
553,889,-390

--- scanner 2 ---
649,640,665
682,-795,504
-784,533,-524
-644,584,-595
-588,-843,648
-30,6,44
-674,560,763
500,723,-460
609,671,-379
-555,-800,653
-675,-892,-343
697,-426,-610
578,704,681
493,664,-388
-671,-858,530
-667,343,800
571,-461,-707
-138,-166,112
-889,563,-600
646,-828,498
640,759,510
-630,509,768
-681,-892,-333
673,-379,-804
-742,-814,-386
577,-820,562

--- scanner 3 ---
-589,542,597
605,-692,669
-500,565,-823
-660,373,557
-458,-679,-417
-488,449,543
-626,468,-788
338,-750,-386
528,-832,-391
562,-778,733
-938,-730,414
543,643,-506
-524,371,-870
407,773,750
-104,29,83
378,-903,-323
-778,-728,485
426,699,580
-438,-605,-362
-469,-447,-387
509,732,623
647,635,-688
-868,-804,481
614,-800,639
595,780,-596

--- scanner 4 ---
727,592,562
-293,-554,779
441,611,-461
-714,465,-776
-743,427,-804
-660,-479,-426
832,-632,460
927,-485,-438
408,393,-506
466,436,-512
110,16,151
-258,-428,682
-393,719,612
-211,-452,876
808,-476,-593
-575,615,604
-485,667,467
-680,325,-822
-627,-443,-432
872,-547,-609
833,512,582
807,604,487
839,-516,451
891,-625,532
-652,-548,-490
30,-46,-14"""

# ╔═╡ ffb809aa-2a36-40c3-8126-422888960c04
function solve(input)
	scanners = []
	scanner = []
	
	for line in filter(x -> length(x) > 0, split(input, "\n"))
		if line[1:3] == "---"
			if length(scanner) > 0
				push!(scanners, scanner)
			end
			scanner = []
		else
			beacon = map(x -> parse(Int, x), split(line, ","))
			push!(scanner, beacon)
		end
	end
	push!(scanners, scanner)

	n = length(scanners)
	positions = fill(zeros(Int64, 3), n)
	known = fill(false, n)
	known[1] = true

	function overlap(i, j)
		si = Set(scanners[i])

		for p in permutations(1:3)
			for c in product([-1, 1], [-1, 1], [-1, 1])
				t = map(x -> [ci * x[pi] for (pi, ci) in zip(p, c)], scanners[j])
				for u in scanners[i]
					for v in t
						Δ = v .- u
						t2 = map(x -> x .- Δ, t)
						sj = Set(t2)
						sij = si ∩ sj
						if length(sij) >= 12
							positions[j] = positions[1] .- Δ
							scanners[j] = t2
							return true
						end
					end
				end
			end
		end
			
		return false
	end

	for _ in 1:n-1
		for i in 1:n
			for j in 1:n
				if known[i] && !known[j]
					if overlap(i, j)
						known[j] = true
					end
				end
			end
		end
	end

	println(scanners)
	
	beacons = Set(scanners[1])
	for i in 2:n
		beacons = beacons ∪ Set(scanners[i])
	end

	return length(beacons), maximum(sum(abs(xi - xj) for (xi, xj) in zip(u, v)) for u in positions for v in positions)
end

# ╔═╡ 9c3b7a34-c4d2-4894-b723-cae30477e846
solve(sample)

# ╔═╡ b3a9e809-794f-4921-85e4-06ea27748752
solve(input)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Combinatorics = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
DotEnv = "4dc1fcf4-5e3b-5448-94ab-0c38ec0385c1"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
IterTools = "c8e1da08-722c-5040-9ed9-7db0dc04731e"

[compat]
Combinatorics = "~1.0.2"
DotEnv = "~0.3.1"
HTTP = "~0.9.17"
IterTools = "~1.4.0"
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

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

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

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

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
# ╠═ffb809aa-2a36-40c3-8126-422888960c04
# ╠═9c3b7a34-c4d2-4894-b723-cae30477e846
# ╠═b3a9e809-794f-4921-85e4-06ea27748752
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
