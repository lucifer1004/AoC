from functools import lru_cache

rules = dict()
expanded = dict()

with open('input.txt') as f:
    rows = list(map(lambda x: x.strip(), f))
    idx = 0
    while rows[idx] != '':
        row = rows[idx]
        num, rule = row.split(': ')
        num = int(num)
        parts = []
        for r in rule.split(' | '):
            if '"' in r:
                parts.append([r[1:-1]])
            elif ' ' in r:
                parts.append(r.split())
            else:
                parts.append([r])
        rules[num] = parts
        idx += 1

    @lru_cache(None)
    def expand(num):
        s = set()
        for part in rules[num]:
            now = ['']
            for p in part:
                nxt = []
                if p.isnumeric():
                    m = int(p)
                    expand(m)
                    for x in now:
                        for y in expanded[m]:
                            nxt.append(x + y)
                else:
                    for x in now:
                        nxt.append(x + p)
                now = nxt
            s = s.union(set(now))
        expanded[num] = s

    expand(0)

    def check(s, rule):
        n = len(s)
        hi = [-1] * (n + 1)
        lo = [-1] * (n + 1)
        hi[0] = 0
        lo[0] = 0
        for i in range(1, n + 1):
            for j in range(i):
                if hi[j] < 0:
                    continue
                if s[j:i] in expanded[rule]:
                    if hi[i] == -1:
                        hi[i] = hi[j] + 1
                        lo[i] = lo[j] + 1
                    else:
                        hi[i] = max(hi[i], hi[j] + 1)
                        lo[i] = min(lo[i], lo[j] + 1)
        return (lo[n], hi[n])

    # Part I
    ans1 = 0
    for row in rows[idx + 1:]:
        if row in expanded[0]:
            ans1 += 1
    print(ans1)

    # Part II
    ans2 = 0
    for row in rows[idx + 1:]:
        n = len(row)
        can = False
        for l in range(2, n):
            left = row[:l]
            right = row[l:]
            ll, lr = check(left, 42)
            rl, rr = check(right, 31)
            if lr < 1 or rr < 1:
                continue
            if lr > rl:
                can = True
                break
        if can:
            ans2 += 1
    print(ans2)
