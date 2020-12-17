from collections import defaultdict

with open('input.txt') as f:
    for row in f:
        commands = list(map(int, row.split(',')))

        def solve(input):
            nums = defaultdict()
            for i, num in enumerate(commands):
                nums[i] = num
            output = []
            i = 0
            rb = 0
            while i < len(commands):
                opcode = str(nums[i]).rjust(5, '0')

                def get_val(offset):
                    mode = opcode[3 - offset]
                    if mode == '0':
                        return nums[nums[i + offset]]
                    elif mode == '1':
                        return nums[i + offset]
                    else:
                        return nums[nums[i + offset] + rb]

                def get_ref(offset):
                    mode = opcode[3 - offset]
                    assert(mode != '1')
                    if mode == '0':
                        return nums[i + offset]
                    else:
                        return nums[i + offset] + rb

                op = nums[i] % 100
                if op == 1:
                    nums[get_ref(3)] = get_val(1) + get_val(2)
                    i += 4
                elif op == 2:
                    nums[get_ref(3)] = get_val(1) * get_val(2)
                    i += 4
                elif op == 3:
                    nums[get_ref(1)] = input
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
                    nums[get_ref(3)] = 1 if get_val(1) < get_val(2) else 0
                    i += 4
                elif op == 8:
                    nums[get_ref(3)] = 1 if get_val(1) == get_val(2) else 0
                    i += 4
                elif op == 9:
                    rb += get_val(1)
                    i += 2
                elif op == 99:
                    break
            return output[-1]

        # Part I
        print(solve(1))

        # Part II
        print(solve(2))
