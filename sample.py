import random, unittest
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



class TestSum(unittest.TestCase):


    def gen_test(self):
        answers = [random.randint(RandLowerBound, RandUpperBound) for _ in range(N)]
        coefficients = [[random.randint(RandLowerBound, RandUpperBound) for _ in range(N)] for _ in range(N)]
        products = []
        for i in range(N):
            products.append(0)
            for j in range(N):
                products[i] += coefficients[i][j] * answers[j]
        return coefficients, products, answers


    def test_gaussian_elimination(self):

        coefficients, products, answers = self.gen_test()
        s = solve(coefficients, products)
        for i in range(N):
            self.assertAlmostEqual(s[i], answers[i])

if __name__ == '__main__':
    unittest.main()