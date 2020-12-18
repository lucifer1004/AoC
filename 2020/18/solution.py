default_order = {'#': -1, '(': 0, '$': 0}


def calc(a, b, o):
    return {'+': a + b, '-': a - b, '*': a * b, '/': a // b}[o]


def calculate(row, order):
    val = []
    op = ['#']

    def pop():
        assert(len(op) >= 1)
        assert(len(val) >= 2)
        o = op.pop()
        b = val.pop()
        a = val.pop()
        val.append(calc(a, b, o))

    for c in row + '$':
        if c in '0123456789':
            val.append(int(c))
        elif c == ')':
            while op[-1] != '(':
                pop()
            op.pop()
        else:
            assert(c in order)
            if c != '(':
                while order[op[-1]] >= order[c]:
                    pop()
            op.append(c)

    assert(len(val) == 1)
    assert(op == ['#', '$'])
    return val[0]


with open('input.txt') as f:
    rows = list(map(lambda x: ''.join(x.strip().split()), f))

    # Part I
    ans1 = 0
    order1 = {'+': 1, '*': 1, **default_order}
    for row in rows:
        ans1 += calculate(row, order1)
    print('Answer to Part I:', ans1)

    # Part II
    ans2 = 0
    order2 = {'+': 2, '*': 1, **default_order}
    for row in rows:
        ans2 += calculate(row, order2)
    print('Answer to Part II:', ans2)
