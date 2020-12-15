from collections import defaultdict


def solve(target):
    with open('input.txt') as f:
        for row in f:
            occur = defaultdict(lambda: [])
            numbers = list(map(int, row.split(',')))

            for i, num in enumerate(numbers):
                occur[num] = [i]

            while len(numbers) < target:
                last = numbers[-1]
                num = 0 if len(occur[last]) == 1 else (
                    occur[last][-1] - occur[last][-2])
                occur[num].append(len(numbers))
                numbers.append(num)

            print(numbers[-1])


# Part I
solve(2020)

# Part II
solve(30000000)
