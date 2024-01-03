# a simple implementation of algorithm to have a guideline

def solve(coefficients, products, n):
    for i in range(n):
        ind = i 
        while coefficients[ind][i] == 0:
            ind += 1
            if ind == n:
                raise ValueError("not solvable")
            
        coefficients[i], coefficients[ind] = coefficients[ind], coefficients[i]
        products[i], products[ind] = products[ind], products[i]

        products[i] = products[i] / coefficients[i][i]
        coefficients[i] = [x / coefficients[i][i] for x in coefficients[i]]




        for j in range(n):
            if j == i:
                continue
            ratio = coefficients[j][i] # / coefficients[i][i]
            products[j] -= ratio * products[i]
            for k in range(i, n):
                coefficients[j][k] -= ratio * coefficients[i][k]

    return products

n = 2
# Gaussian Elimination
coefficients = []
for i in range(n):
    coefficients.append(list(map(float, input().split())))

products = []
for i in range(n):
    products.append(float(input()))

print("ANS")
for i in solve(coefficients, products, n):
    print(i)