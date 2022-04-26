from zipf import make_zipf, is_zipf

generated = make_zipf(5)
print(f'generated distribution: {generated}')
generated[-1] *= 2
print(f'passes test with default tolerance: {is_zipf(generated)}')
print(f'passes test with tolerance of 1.0: {is_zipf(generated, rel=1.0)}')
