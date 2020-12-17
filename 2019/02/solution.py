from collections import defaultdict

with open('input.txt') as f:
    for row in f:
        nums = list(map(int, row.split(',')))

        def solve(noun, verb):
            nums[1] = noun
            nums[2] = verb
            ans = defaultdict()
            for i, num in enumerate(nums):
                ans[i] = num
            i = 0
            while i < len(nums):
                if nums[i] == 1:
                    ans[nums[i + 3]] = ans[nums[i + 1]] + ans[nums[i + 2]]
                    i += 4
                elif nums[i] == 2:
                    ans[nums[i + 3]] = ans[nums[i + 1]] * ans[nums[i + 2]]
                    i += 4
                elif nums[i] == 99:
                    break
            return ans[0]

        # Part I
        print(solve(12, 2))

        # Part II
        for noun in range(100):
            for verb in range(100):
                if solve(noun, verb) == 19690720:
                    print(100 * noun + verb)
                    exit(0)
