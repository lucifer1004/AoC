import re

rules = []
my_ticket = []
nearby_tickets = []
with open('input.txt') as f:
    state = 0
    for row in f:
        row = row.strip()
        if row == 'your ticket:':
            state = 1
        elif row == 'nearby tickets:':
            state = 2
        elif row == '':
            continue
        elif state == 0:
            m = re.match(r'([a-z\s]+): (\d+)-(\d+) or (\d+)-(\d+)', row)
            if m:
                rules.append((m.group(1), int(m.group(2)),
                              int(m.group(3)), int(m.group(4)), int(m.group(5))))
        elif state == 1:
            my_ticket = list(map(int, row.split(',')))
        elif state == 2:
            nearby_tickets.append(list(map(int, row.split(','))))

# Part I

ans1 = 0
valid_nearby_tickets = []
for ticket in nearby_tickets:
    ticket_valid = True
    for num in ticket:
        num_valid = False
        for j, rule in enumerate(rules):
            key, ll, lr, rl, rr = rule
            if ll <= num <= lr or rl <= num <= rr:
                num_valid = True
                break
        if not num_valid:
            ans1 += num
            ticket_valid = False
    if ticket_valid:
        valid_nearby_tickets.append(ticket)
print('Answer to Part I:', ans1)

# Part II

n = len(rules)
p = [set() for _ in range(n)]
for ticket in valid_nearby_tickets:
    for i, num in enumerate(ticket):
        for j, rule in enumerate(rules):
            key, ll, lr, rl, rr = rule
            if not (ll <= num <= lr or rl <= num <= rr):
                p[i].add(j)

mask = 1 << n
dp = [False] * mask
order = [[] for _ in range(mask)]
dp[0] = True

for key in range(n):
    ndp = list(dp)
    pmask = 1 << key
    for state in range(mask - 1, -1, -1):
        if not dp[state]:
            continue
        for pos in range(n):
            if state & (1 << pos) > 0:
                continue
            if key not in p[pos]:
                nxt = state | (1 << pos)
                ndp[nxt] = True
                order[nxt] = list(order[state]) + [pos]
    dp = list(ndp)

true_order = order[mask - 1]
ans2 = 1
for i, rule in enumerate(rules):
    key, *rest = rule
    if 'departure' in key:
        ans2 *= my_ticket[true_order[i]]
print('Answer to Part II:', ans2)
