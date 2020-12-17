def handle_contents(contents):
    resolved = []
    for parts in contents.split(', '):
        parts = parts.split()
        if not parts[0].isnumeric():
            continue
        num = int(parts[0])
        color = ' '.join(parts[1:-1])
        resolved.append((color, num))
    return resolved


with open('input.txt') as f:
    descriptions = list(map(lambda x: x.strip().split(' bags contain '), f))
    bags = {color: handle_contents(contents)
            for color, contents in descriptions}

    # Part I
    ans1 = 0
    for color in bags:
        vis = set()

        def explore(u):
            for v, _num in bags[u]:
                if v not in vis:
                    vis.add(v)
                    explore(v)

        explore(color)
        if 'shiny gold' in vis:
            ans1 += 1
    print(ans1)

    # Part II
    def count(u):
        ans = 1
        for v, num in bags[u]:
            ans += num * count(v)
        return ans

    print(count('shiny gold') - 1)
