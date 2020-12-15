import re
from collections import defaultdict

# Handle input
operations = []
mask = ''
operands = []
with open('input.txt') as f:
    for row in f:
        m = re.match(r'mask = (.*)', row)
        if m:
            if mask != '':
                operations.append((mask, operands))
            operands = []
            mask = m.group(1)
        else:
            m = re.match(r'mem\[(\d+)\] = (\d+)', row)
            operands.append((int(m.group(1)), int(m.group(2))))
if mask != '':
    operations.append((mask, operands))

# Part I
d1 = defaultdict(lambda: 0)
for mask, operands in operations:
    for pos, value in operands:
        actual_value = value
        for i, c in enumerate(mask):
            if c == 'X':
                continue
            bitmask = 1 << (len(mask) - 1 - i)
            if c == '0':
                actual_value = (actual_value | bitmask) ^ bitmask
            else:
                actual_value = actual_value | bitmask
        d1[pos] = actual_value
print(sum(d1.values()))

# Part II
d2 = defaultdict(lambda: 0)
for mask, operands in operations:
    for pos, value in operands:
        actual_positions = set([pos])
        for i, c in enumerate(mask):
            next_positions = set()
            bitmask = 1 << (len(mask) - 1 - i)
            for position in actual_positions:
                if c == 'X' or c == '1':
                    next_positions.add(position | bitmask)
                if c == 'X':
                    next_positions.add((position | bitmask) ^ bitmask)
                if c == '0':
                    next_positions.add(position)
            actual_positions = set(next_positions)
        for position in actual_positions:
            d2[position] = value
print(sum(d2.values()))
