class Node:
    def __init__(self, val) -> None:
        self.val = val
        self.next = None


def build(arr):
    sentinel = Node(0)
    d = dict()
    p = sentinel
    for i in arr:
        p.next = Node(i)
        d[i] = p.next
        p = p.next
    p.next = sentinel.next
    return (sentinel.next, d)


def simulate(p, d, n):
    l = p.next
    r = p.next.next.next
    p.next = r.next
    s = set([l.val, l.next.val, r.val])
    dest = p.val - 1
    if dest == 0:
        dest = n
    while dest in s:
        dest -= 1
        if dest == 0:
            dest = n
    pos = d[dest]
    r.next = pos.next
    pos.next = l
    return p.next


cups = [9, 2, 5, 1, 7, 6, 8, 3, 4]
n = len(cups)

# Part I
c1, d1 = build(cups)
t1 = 100
for _ in range(t1):
    c1 = simulate(c1, d1, n)
o1 = d1[1]
ans1 = []
for _ in range(n - 1):
    o1 = o1.next
    ans1.append(o1.val)
print('Part I:', ''.join(map(str, ans1)))

# Part II
n2 = 1000000
t2 = 10000000
c2, d2 = build(cups + [i + n + 1 for i in range(n2 - n)])
for _ in range(t2):
    c2 = simulate(c2, d2, n2)
o2 = d2[1]
print('Part II:', o2.next.val * o2.next.next.val)
