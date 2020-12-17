def decode(ticket):
    num = 0
    for c in ticket:
        num <<= 1
        if c in 'BR':
            num += 1
    return num


with open('input.txt') as f:
    tickets = list(map(lambda x: decode(x.strip()), f))

    # Part I
    print(max(tickets))

    # Part II
    s = set(tickets)
    for num in range(min(tickets), max(tickets)):
        if num not in s:
            print(num)
            break
