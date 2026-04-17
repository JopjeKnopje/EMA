from pathlib import Path
from random import randrange

from cyclopts import App

app = App()



def write_to_file(file: Path, data: list[int]) -> None:
    str_data = [str(x) for x in data]
    with file.open("w") as f:
        for sample in str_data:
            f.writelines(f"{sample}\n")



@app.command
@app.default
def random(n: int = 32, min: int = 0, max: int = 256, file: Path | None = None) -> list[int] | None:
    """
    Generate `n` amount of random integers 
    """
    samples: list[int] = []
    for i in range(n):
        samples.append(randrange(min, max))

    if file is not None:
        write_to_file(file, samples)
    else:
        return samples

app()
