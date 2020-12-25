card = 17607508
door = 15065270
mod = 20201227


def encode(initial, loops):
    return pow(initial, loops + 1, mod)


def loop(key):
    i = 0
    num = 7
    while num != key:
        num = num * 7 % mod
        i += 1
    return i


def solve(card, door):
    card_loop = loop(card)
    door_loop = loop(door)
    code = encode(card, door_loop)
    assert(code == encode(door, card_loop))
    return code


print(solve(card, door))
