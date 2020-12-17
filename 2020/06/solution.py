with open('input.txt') as f:
    rows = list(map(lambda x: x.strip(), f))
    groups = '\n'.join(rows).split('\n\n')
    ans1 = 0
    ans2 = 0
    for group in groups:
        any_ = set()
        all_ = set()
        for i, person in enumerate(group.split('\n')):
            curr = set(list(person))
            if i == 0:
                any_ = curr
                all_ = curr
            else:
                any_ = any_.union(curr)
                all_ = all_.intersection(curr)
        ans1 += len(any_)
        ans2 += len(all_)
    print(ans1)
    print(ans2)
