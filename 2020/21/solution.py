from collections import defaultdict

ingredients = set()
allergens = defaultdict(lambda: set())
possible = set()
parsed = []
rows = list(map(lambda x: x.strip(), open('input.txt')))
for row in rows:
    a, b = row.split(' (contains ')
    a = a.split()
    b = b[:-1].split(', ')
    parsed.append((a, b))
    for bi in b:
        first = len(allergens[bi]) == 0
        if first:
            allergens[bi] = set(a)
        else:
            allergens[bi] = allergens[bi].intersection(set(a))
for bi in allergens:
    possible = possible.union(allergens[bi])

# Part I
ans1 = 0
for a, b in parsed:
    for ai in a:
        if ai not in possible:
            ans1 += 1
print(ans1)

# Part II: Hungary
vis = set()
link = defaultdict(lambda: '')
match = 0


def find(ingredient):
    for bi in allergens:
        if ingredient in allergens[bi] and bi not in vis:
            vis.add(bi)
            if link[bi] == '' or find(link[bi]):
                link[bi] = ingredient
                return True
    return False


def hungary():
    global match
    for ai in possible:
        vis.clear()
        if find(ai):
            match += 1


hungary()
matches = [(bi, link[bi]) for bi in link]
matches.sort()
print(','.join(x[1] for x in matches))
