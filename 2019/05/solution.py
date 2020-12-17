with open('input.txt') as f:
    for row in f:
        commands = list(map(int, row.split(',')))

        def solve(input):
            nums = list(commands)
            output = []
            i = 0
            while i < len(nums):
                opcode = str(nums[i]).rjust(5, '0')

                def get_val(offset):
                    return nums[nums[i + offset]] if opcode[3 - offset] == '0' else nums[i + offset]

                op = nums[i] % 100
                if op == 1:
                    nums[nums[i + 3]] = get_val(1) + get_val(2)
                    i += 4
                elif op == 2:
                    nums[nums[i + 3]] = get_val(1) * get_val(2)
                    i += 4
                elif op == 3:
                    nums[nums[i + 1]] = input
                    i += 2
                elif op == 4:
                    output.append(get_val(1))
                    i += 2
                elif op == 5:
                    if get_val(1) != 0:
                        i = get_val(2)
                    else:
                        i += 3
                elif op == 6:
                    if get_val(1) == 0:
                        i = get_val(2)
                    else:
                        i += 3
                elif op == 7:
                    nums[nums[i + 3]] = 1 if get_val(1) < get_val(2) else 0
                    i += 4
                elif op == 8:
                    nums[nums[i + 3]] = 1 if get_val(1) == get_val(2) else 0
                    i += 4
                elif op == 99:
                    break
            return output[-1]

        # Part I
        print(solve(1))

        # Part II
        print(solve(5))
