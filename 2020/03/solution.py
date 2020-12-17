def solve(trees, patterns):
    ans = 1
    height = len(trees)
    width = len(trees[0])
    for dc, dr in patterns:
        c = 0
        r = 0
        cnt = 0
        while r < height:
            if trees[r][c] == '#':
                cnt += 1
            c = (c + dc) % width
            r += dr
        ans *= cnt
    print(ans)


with open('input.txt') as f:
    trees = list(map(lambda x: x.strip(), f))

    # Part I
    solve(trees, [(3, 1)])

    # Part II
    solve(trees, [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)])
