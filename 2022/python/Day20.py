from pathlib import PosixPath

nums = list(
    enumerate(map(int, open(PosixPath('..', 'inputs', '20.txt')).read().split('\n'))))
n = len(nums)
nxt = list(nums)


def swap(i, j):
    i = (i % n + n) % n
    j = (j % n + n) % n
    nxt[i], nxt[j] = nxt[j], nxt[i]


for num in nums:
    i = 0
    while nxt[i] != num:
        i += 1

    if num[1] > 0:
        for j in range(num[1] % (n - 1)):
            swap(i + j, i + j + 1)
    elif num[1] < 0:
        for j in range(-num[1] % (n - 1)):
            swap(i - j, i - j - 1)


i = 0
while nxt[i][1] != 0:
    i += 1

ans = 0
for j in range(3):
    for k in range(1000):
        i = (i + 1) % n
    ans += nxt[i][1]

print('Part 1:', ans)

nxt = list(nums)
special = 811589153
for t in range(10):
    for num in nums:
        i = 0
        while nxt[i] != num:
            i += 1

        if num[1] > 0:
            for j in range(num[1] * special % (n - 1)):
                swap(i + j, i + j + 1)
        elif num[1] < 0:
            for j in range(-num[1] * special % (n - 1)):
                swap(i - j, i - j - 1)

i = 0
while nxt[i][1] != 0:
    i += 1

ans = 0
for j in range(3):
    for k in range(1000):
        i = (i + 1) % n
    ans += nxt[i][1]

print('Part 2:', ans * special)
