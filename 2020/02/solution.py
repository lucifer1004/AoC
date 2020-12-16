import re

data = []
with open('input.txt') as f:
    for row in f:
        m = re.match(r'(\d+)-(\d+) ([a-z]): ([a-z]+)', row)
        data.append((int(m.group(1)), int(m.group(2)), m.group(3), m.group(4)))

# Part I

ans = 0
for l, r, ch, s in data:
    if l <= s.count(ch) <= r:
        ans += 1
print(ans)

# Part II

ans = 0
for l, r, ch, s in data:
    cnt = 0
    if s[l - 1] == ch:
        cnt += 1
    if s[r - 1] == ch:
        cnt += 1
    if cnt == 1:
        ans += 1
print(ans)
