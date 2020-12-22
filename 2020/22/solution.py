def rec(a, b, depth, recursive=False):
    vis = set()
    while len(a) > 0 and len(b) > 0:
        config = (tuple(a), tuple(b))
        if recursive and config in vis:
            if depth == 0:
                print(sum((len(a) - i) * x for i, x in enumerate(a)))
            return True
        a0 = a.pop(0)
        b0 = b.pop(0)
        vis.add(config)
        win = True
        if recursive and len(a) >= a0 and len(b) >= b0:
            win = rec(a[:a0], b[:b0], depth + 1, True)
        else:
            win = a0 > b0
        if win:
            a.append(a0)
            a.append(b0)
        else:
            b.append(b0)
            b.append(a0)

    if depth > 0:
        return len(a) > 0
    else:
        if len(a) > 0:
            print(sum((len(a) - i) * x for i, x in enumerate(a)))
        else:
            print(sum((len(b) - i) * x for i, x in enumerate(b)))
        return len(a) > 0


rows = list(map(lambda x: x.strip(), open('input.txt')))
sep = rows.index('Player 2:')
a = list(map(int, rows[1:sep - 1]))
b = list(map(int, rows[sep + 1:]))

# Part I
rec(list(a), list(b), 0)

# Part II
rec(list(a), list(b), 0, True)
