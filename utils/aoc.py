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


d4n = {'E': (1, 0), 'S': (0, -1), 'W': (-1, 0), 'N': (0, 1)}
d4n2 = {'R': (1, 0), 'U': (0, -1), 'L': (-1, 0), 'D': (0, 1)}
d4 = [(-1, 0), (0, -1), (1, 0), (0, 1)]
d8 = [(-1, 0), (-1, -1), (0, -1), (1, -1), (1, 0), (1, 1), (0, 1), (-1, 1)]
