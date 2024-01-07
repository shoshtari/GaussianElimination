import random, unittest
N = 2
RandLowerBound = -10
RandUpperBound = 10


def frac_solve(coefficients: list[list], products: list):
    '''apply GaussianElimination to Solve N equations with coefficients and products matrices'''

    order = [-1 for i in range(N)]

    coefficients_denom = [[1 for _ in range(N)] for _ in range(N)]
    products_denom = [1 for _ in range(N)]

    for this_row in range(N):
        index = 0
        while coefficients[this_row][index] < 0.1:
            index += 1
            if index >= N:
                print("ERR", coefficients, this_row)
        # find the first non-zero index in coefficients[this_row] equation

        order[index] = this_row
        print(products, products_denom)

        # products[this_row] /= coefficients[this_row][index]
        products[this_row] *= coefficients_denom[this_row][index]
        products_denom[this_row] *= coefficients[this_row][index]

        coe = coefficients[this_row][index]
        coe_denom = coefficients_denom[this_row][index]
        
        for i in range(N):
            # coefficients[this_row][i] /= coe
            coefficients[this_row][i] *= coe_denom
            coefficients_denom[this_row][i] *= coe

        # make that index in other equations zero
        for row in range(N):
            if row == this_row:
                continue
            coe = coefficients[row][index]
            coe_denom = coefficients_denom[row][index]

            for column in range(N):
                # coefficients[row][column] -= coe * coefficients[this_row][column]

                to_be_decrease = coe * coefficients[this_row][column]
                to_be_decrease_denom = coe_denom * coefficients_denom[this_row][column]

                coefficients[row][column] = \
                    coefficients[row][column] * to_be_decrease_denom - to_be_decrease * coefficients_denom[row][column]
                coefficients_denom[row][column] *= to_be_decrease_denom

            # products[row] -= coe * products[this_row]

            to_be_decrease = coe * products[this_row]
            to_be_decrease_denom = coe_denom * products_denom[this_row]

            products[row] = products[row] * to_be_decrease_denom - to_be_decrease * products_denom[this_row]
            products_denom[row] *= to_be_decrease_denom

    return [products[i] / products_denom[i]  for i in order]



def solve(coefficients: list[list], products: list):
    '''apply GaussianElimination to Solve N equations with coefficients and products matrices'''

    order = [-1 for i in range(N)]
    # order of variables in product matrix


    for this_row in range(N):
        index = 0
        while coefficients[this_row][index] < 0.1:
            index += 1
            if index >= N:
                print("ERR")
        # find the first non-zero index in coefficients[this_row] equation

        order[index] = this_row

        products[this_row] /= coefficients[this_row][index]

        coe = coefficients[this_row][index]
        
        for i in range(N):
            coefficients[this_row][i] /= coe

        # make that index in other equations zero
        for row in range(N):
            if row == this_row:
                continue
            coe = coefficients[row][index]

            for column in range(N):
                coefficients[row][column] -= coe * coefficients[this_row][column]

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
        # s = solve(coefficients, products)
        s = frac_solve(coefficients, products)
        for i in range(N):
            self.assertAlmostEqual(s[i], answers[i])

if __name__ == '__main__':
    random.seed(1)
    unittest.main()