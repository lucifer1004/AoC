from collections import Counter

step = {'e': (0, 1), 'se': (-1, 1), 'sw': (-1, 0),
        'w': (0, -1), 'nw': (1, -1), 'ne': (1, 0)}

rows = list(map(lambda x: x.strip(), open('input.txt')))
cnt = Counter()
for row in rows:
    r = 0
    c = 0
    i = 0
    while i < len(row):
        s = row[i]
        if row[i] in 'sn':
            s = s + row[i + 1]
            i += 1
        dr, dc = step[s]
        r += dr
        c += dc
        i += 1
    cnt[(r, c)] += 1

black = set()
ans1 = 0
for key in cnt:
    if cnt[key] % 2 == 1:
        ans1 += 1
        black.add(key)
print('Part I: ', ans1)

for _ in range(100):
    nxt = set()
    nei = Counter()
    for r, c in black:
        for dr, dc in step.values():
            nei[(r + dr, c + dc)] += 1
    black = {(r, c) for (r, c) in nei if ((r, c) not in black and nei[(
        r, c)] == 2) or ((r, c) in black and 1 <= nei[(r, c)] <= 2)}

print('Part II: ', len(black))
