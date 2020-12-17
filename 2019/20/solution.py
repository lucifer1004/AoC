from collections import defaultdict, deque

character = set(list('ABCDEFGHIJKLMNOPQRSTUVWXYZ'))
cell = '.'
d4 = [(0, -1), (-1, 0), (0, 1), (1, 0)]
portals = defaultdict(lambda: [])
pairs = dict()
inner = set()
outer = set()

with open('input.txt') as f:
    maze = list(f)
    rows = len(maze)
    columns = len(maze[0]) - 1
    for i in range(rows):
        for j in range(columns):
            if maze[i][j] in character:
                if j + 2 < columns and maze[i][j + 1] in character and maze[i][j + 2] == cell:
                    name = maze[i][j] + maze[i][j + 1]
                    portals[name].append((i, j + 2))
                    if j == 0:
                        outer.add((i, j + 2))
                    else:
                        inner.add((i, j + 2))
                elif j + 1 < columns and j > 0 and maze[i][j + 1] in character and maze[i][j - 1] == cell:
                    name = maze[i][j] + maze[i][j + 1]
                    portals[name].append((i, j - 1))
                    if j + 2 == columns:
                        outer.add((i, j - 1))
                    else:
                        inner.add((i, j - 1))
                elif i + 2 < rows and maze[i + 1][j] in character and maze[i + 2][j] == cell:
                    name = maze[i][j] + maze[i + 1][j]
                    portals[name].append((i + 2, j))
                    if i == 0:
                        outer.add((i + 2, j))
                    else:
                        inner.add((i + 2, j))
                elif i + 1 < rows and i > 0 and maze[i + 1][j] in character and maze[i - 1][j] == cell:
                    name = maze[i][j] + maze[i + 1][j]
                    portals[name].append((i - 1, j))
                    if i + 2 == rows:
                        outer.add((i - 1, j))
                    else:
                        inner.add((i - 1, j))
    for name in portals:
        if len(portals[name]) == 2:
            u, v = portals[name]
            pairs[u] = v
            pairs[v] = u

    # Part I
    start = portals['AA'][0]
    end = portals['ZZ'][0]
    dq = deque()
    dq.append((start, 0))
    vis = set()
    while len(dq) > 0:
        pos, steps = dq.popleft()
        if pos == end:
            print(steps)
            break
        r, c = pos
        for dr, dc in d4:
            nr, nc = r + dr, c + dc
            if maze[nr][nc] == cell and (nr, nc) not in vis:
                vis.add((nr, nc))
                dq.append(((nr, nc), steps + 1))
        if pos in pairs and pairs[pos] not in vis:
            vis.add(pairs[pos])
            dq.append((pairs[pos], steps + 1))

    # Part II
    sr, sc = portals['AA'][0]
    er, ec = portals['ZZ'][0]
    outer.remove((sr, sc))
    outer.remove((er, ec))
    dq = deque()
    dq.append((sr, sc, 0, 0))
    vis = set()
    while len(dq) > 0:
        r, c, level, steps = dq.popleft()
        if r == er and c == ec:
            print(steps)
            break
        for dr, dc in d4:
            nr, nc = r + dr, c + dc
            if maze[nr][nc] == cell and (nr, nc, level) not in vis:
                if nr == er and nc == ec and level > 0:
                    continue
                if nr == sr and nc == sc and level > 0:
                    continue
                if (nr, nc) in outer and level == 0:
                    continue
                vis.add((nr, nc, level))
                dq.append((nr, nc, level, steps + 1))
        pos = (r, c)
        if pos in pairs:
            nr, nc = pairs[pos]
            nxt = (nr, nc, level + 1) if pos in inner else (nr, nc, level - 1)
            if nxt not in vis:
                vis.add(nxt)
                dq.append((*nxt, steps + 1))
