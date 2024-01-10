# CA LAB Project
Morteza Malekinejad Shooshtari
Mohammd Hossein Haghadadi
# Introduction
our goal in this project was to design hardware that can solve n equalities with n unknowns using an algorithm known as Gaussian Elimination[[+]](https://en.wikipedia.org/wiki/Gaussian_eliminationhttps://website-name.com).

you can find the descriptions of the algorithm, here I just explain the challenges, solutions, and structure of our code.

# Challenges
gaussian elimination takes heavy use of fractions and floating division which we don't have in VHDL, so we did some research and tried different ways.
## Solutions we examine for division
### loop with multiple add/sub
we tried a loop to do multiple subtractions of the value of the quotient until it matches the equation, one of the drawbacks of this method is it will change the value of initial variables and we should store a copy of them elsewhere.
### loop with fixed steps
it is like the previous method with 1 difference, instead of adding/sub the quotient, we just increase/decrease the answer, it is simpler and more foolproof than the last method.

it just has two drawbacks.
it needs more calculation than the last one (we calculate a multiply at each step) but since we have multiple CLB, it is no problem in our scale (n's maximum value is 10)
the other one is that it is just for integer numbers (like the previous method) and we need fraction calculation in Gaussian Elimination
### Nominator and Denominator
one of our methods was to store two numbers for each variable, a nominator and denominator, when we wanted to divide a by b, we just multiplied a's denominator by b, and at the final step, we did an integer division (since our answers are integer) to get the value.

we thought that this was the thing but it turned out there was just one problem. in a Python demo we had created, we tested this and at `N = 10` Python raised an error indicating that a number had exceeded 10^300 and it was too large. at `N = 5` it has crossed the C limit.

### Common denominator
we tried to combine methods 2 and 3, resulting in a common denominator idea.

here is the thing: instead of worrying about floats and fractions and so on, we just multiply two equations by each other and then subtract them to eliminate a variable. (instead of dividing one of them).

### Floating point numbers
it is one of the obvious! we just could use the float or fixed point numbers which were added to VHDL in 2008.

unfortunately, our hardware didn't support it.
### conclusion
we used the VHDL float package in our main design but because we were worried that our hardware and its development environment didn't support this, (since it was added in 2008 and not in initial versions of VHDL we designed a second hardware that used the common denominator technique to calculate the results. 

## The problem of multiple loops
Gaussian elimination core logic consists of three for loops, we couldn't do it in VHDL since there were too many changes for just one clock and we couldn't use signals and in fact, we would lose concurrency.

so we tried to do it by the clock. breaking our design into `N` different states and at each clock, we eliminate a variable.

## The problem of while

we couldn't use while because it's indeterministic so we used a fixed for loop and an if in it. since for maximum iteration is 8, there are no concerns about performance.

# Structure of code

## Python
we wrote a  simple Python code to first check our logic and algorithms.

at each step, we first changed this file to see if we didn't break our code by an optimization or improvement. 

it has a unit test with a variety of inputs to make sure there is no room for error.


## VHDL
there is a file `package.vhd` which just defines the types of our pins. the main design is in `compute.vhd` which has a generic `N` that determines the number of equations. it's input/output must be in format of float16 (read this article to find more [[+]](http://math.unife.it/ing/informazione/Linguaggi-hw/lucidi-delle-lezioni/lucidi-anni-precedenti-al-2019-2020/aritmetica-fixed-e-floating-point-in-vhdl))
with four bits for exponent and 9 bits for mantis.

there is another file named `simplified.vhd` which is our 2 equation solver to demonstrate a POC on our FPGA (spartan3).

and there is a simple module `divider.vhd` which will integer division of two numbers in 8 steps.

the other files are just testbenches for us to verify the answer.