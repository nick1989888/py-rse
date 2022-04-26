from random import uniform

RELATIVE_ERROR = 0.05

def make_zipf(length):
    assert length > 0, 'Zipf distribution must have at least one element'
    return [1/(1 + i) for i in range(length)]


def make_noisy_zipf(length, rel=RELATIVE_ERROR):
    data = make_zipf(length)
    minnoise = 1.0 - rel/2
    maxnoise = 1.0 + rel/2
    for i in range(length):
        data[i] = data[i]*uniform(minnoise, maxnoise)
    return data