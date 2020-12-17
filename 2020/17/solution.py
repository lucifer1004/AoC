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
        maze = set()
        for i in range(len(rows)):
            for j in range(len(rows[0])):
                if rows[i][j] == '#':
                    maze.add((i, j, *[0] * extra_dimension))

        for _ in range(cycle):
            nxt = set()
            cnt = defaultdict(lambda: 0)

            for pos in maze:
                for neighbor in get_neighbors(pos):
                    cnt[neighbor] += 1

            for pos in cnt:
                if pos in maze:
                    if 2 <= cnt[pos] <= 3:
                        nxt.add(pos)
                elif cnt[pos] == 3:
                    nxt.add(pos)
            maze = nxt

        print(len(maze))

    # Part I
    solve(3, cycle=6)

    # Part II
    solve(4, cycle=6)
