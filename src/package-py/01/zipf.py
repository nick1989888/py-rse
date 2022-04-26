from pytest import approx


RELATIVE_ERROR = 0.05


def make_zipf(length):
    assert length > 0, 'Zipf distribution must have at least one element'
    return [1/(1 + i) for i in range(length)]


def is_zipf(hist, rel=RELATIVE_ERROR):
    assert len(hist) > 0, 'Cannot test Zipfiness without data'
    scaled = [h/hist[0] for h in hist]
    perfect = make_zipf(len(hist))
    return scaled == approx(perfect, rel=rel)
