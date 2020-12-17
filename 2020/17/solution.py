from collections import defaultdict


def get_neighbors(pos):
    dimension = len(pos)
    neighbors = [()]
    for i in range(dimension):
        nxt = []
        for current in neighbors:
            for j in range(pos[i] - 1, pos[i] + 2):
                nxt.append((*current, j))
        neighbors = nxt
    idx = 0
    while neighbors[idx] != pos:
        idx += 1
    neighbors.pop(idx)
    return neighbors


with open('input.txt') as f:
    rows = list(map(lambda x: x.strip(), f))

    def solve(dimension, cycle):
        assert(dimension >= 2)
        extra_dimension = dimension - 2
        maze = defaultdict(lambda: False)
        for i in range(len(rows)):
            for j in range(len(rows[0])):
                maze[(i, j, *[0] * extra_dimension)] = rows[i][j] == '#'

        for _ in range(cycle):
            nxt = defaultdict(lambda: False)
            cnt = defaultdict(lambda: 0)

            for pos in maze:
                if maze[pos]:
                    for neighbor in get_neighbors(pos):
                        cnt[neighbor] += 1

            for pos in cnt:
                if maze[pos]:
                    nxt[pos] = 2 <= cnt[pos] <= 3
                else:
                    nxt[pos] = cnt[pos] == 3
            maze = nxt

        ans = 0
        for pos in maze:
            if maze[pos]:
                ans += 1
        print(ans)

    # Part I
    solve(3, cycle=6)

    # Part II
    solve(4, cycle=6)
