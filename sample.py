import random
N = 10
RandLowerBound = -100
RandUpperBound = 100


def solve(coefficients: list[list], products: list):
    '''apply GaussianElimination to Solve N equations with coefficients and products matrices'''

    order = [-1 for i in range(N)]
    # order of variables in product matrix

    for this_row in range(N):
        index = 0
        while coefficients[this_row][index] == 0:
            index += 1
        # find the first non-zero index in coefficients[this_row] equation

        order[index] = this_row

        products[this_row] /= coefficients[this_row][index]
        coefficients[this_row] = [x / coefficients[this_row][index]
                                  for x in coefficients[this_row]]

        # make that index in other equations zero
        for row in range(N):
            if row == this_row:
                continue
            coe = coefficients[row][index]
            for column in range(N):
                coefficients[row][column] -= coe * \
                    coefficients[this_row][column]
            products[row] -= coe * products[this_row]

    return [products[i] for i in order]


if __name__ == "__main__":
    coefficients = [[random.randint(RandLowerBound, RandUpperBound)
                     for j in range(N)] for i in range(N)]
    products = [random.randint(RandLowerBound, RandUpperBound)
                for i in range(N)]
    for i in solve(coefficients, products):
        print(i)