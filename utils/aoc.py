import os
import requests
from dotenv import load_dotenv

load_dotenv()
AOC_SESSION = os.getenv('AOC_SESSION')

def get_input(year, day, session=AOC_SESSION):
    cookies = dict(session=session)
    r = requests.get(f'https://adventofcode.com/{year}/day/{day}/input', cookies=cookies)
    return r.text
