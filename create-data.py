# This script creates a 2 column data frame of random Letters (A-Z) and
#  numbers (1-20) and saves it to the working directory as data.csv.

import random
import string
import pandas

# Create random list of letters
randomLet = []
for i in range(0,500):
    a = random.choice(string.ascii_uppercase)
    randomLet.append(a)

# Create random list of numbers from 1-20
randomNum = []
for i in range(0,500):
    n = random.randint(1,20)
    randomNum.append(n)


df = pandas.DataFrame(data = {"Letters": randomLet, "Numbers": randomNum})

df.to_csv("data.csv")
