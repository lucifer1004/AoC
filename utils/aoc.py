import os
import requests
from dotenv import load_dotenv

load_dotenv()
AOC_SESSION = os.getenv('AOC_SESSION')


def get_input(year, day, session=AOC_SESSION):
    cookies = dict(session=session)
    r = requests.get(
        f'https://adventofcode.com/{year}/day/{day}/input', cookies=cookies)
    return r.text

def submit_answer(answer, year, day, level=1, session=AOC_SESSION):
    cookies = dict(session=session)
    r = requests.post(
        f'https://adventofcode.com/{year}/day/{day}/answer', {'level': level, 'answer': answer}, cookies=cookies)
    return r.text


def mat_mul(A, B):
    n = len(A)
    k = len(A[0])
    m = len(B[0])
    ans = [[0] * m for _ in range(n)]
    for p in range(n):
        for q in range(m):
            for i in range(k):
                ans[p][q] += A[p][i] * B[i][q]
    return ans


def mat_exp(A, y):
    n = len(A)
    ans = [[0 if j != i else 1 for j in range(n)] for i in range(n)]
    while y > 0:
        if (y & 1) == 1:
            ans = mat_mul(ans, A)
        A = mat_mul(A, A)
        y >>= 1
    return ans


d4n = {'E': (1, 0), 'S': (0, -1), 'W': (-1, 0), 'N': (0, 1)}
d4n2 = {'R': (1, 0), 'U': (0, -1), 'L': (-1, 0), 'D': (0, 1)}
d4 = [(-1, 0), (0, -1), (1, 0), (0, 1)]
d8 = [(-1, 0), (-1, -1), (0, -1), (1, -1), (1, 0), (1, 1), (0, 1), (-1, 1)]
