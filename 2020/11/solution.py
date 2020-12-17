d8 = [(i, j) for i in range(-1, 2)
      for j in range(-1, 2) if (i, j) != (0, 0)]


def find_neighbors(r, c, seats, valid, keep_trying=False):
    neighbors = []
    for dr, dc in d8:
        delta = 1
        while valid(r + dr * delta, c + dc * delta):
            nr, nc = r + dr * delta, c + dc * delta
            if seats[nr][nc] != '.':
                neighbors.append((nr, nc))
                break
            if not keep_trying:
                break
            delta += 1
    return neighbors


with open('input.txt') as f:
    seats = list(map(lambda x: list(x.strip()), f))
    rows = len(seats)
    columns = len(seats[0])
    def valid(r, c): return 0 <= r < rows and 0 <= c < columns
    close_neighbors = {(r, c): find_neighbors(r, c, seats, valid)
                       for r in range(rows) for c in range(columns)}
    far_neighbors = {(r, c): find_neighbors(r, c, seats, valid, True)
                     for r in range(rows) for c in range(columns)}

    def solve(neighbors, threshold):
        last = [list(row) for row in seats]
        changed = True
        while changed:
            next = [list(row) for row in last]
            changed = False
            for r in range(rows):
                for c in range(columns):
                    cnt = 0
                    for nr, nc in neighbors[(r, c)]:
                        if last[nr][nc] == '#':
                            cnt += 1
                    if last[r][c] == '#' and cnt >= threshold:
                        next[r][c] = 'L'
                        changed = True
                    if last[r][c] == 'L' and cnt == 0:
                        next[r][c] = '#'
                        changed = True
            last = [list(row) for row in next]

        print(sum(row.count('#') for row in last))

    # Part I:
    solve(close_neighbors, 4)

    # Part II:
    solve(far_neighbors, 5)
