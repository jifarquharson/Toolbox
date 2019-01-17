#! /usr/bin/env python3
#@author: Jamie Farquharson

import sys
import ast

import math
import numbers
from collections import Counter
###############################################################################

def incomplete_lower_gamma(s, z):
    '''
    Returns the incomplete lower gamma function as a function of s (degrees of freedom/2)
    and z (chi-squared test statistic/2).
    Technically, upper_lim = infinity, but 100  is more than sufficient to ensure
    convergence of gamma, whilst remaining computationally efficient.
    '''
    gamma = 0
    upper_bound = 100

    for k in range(0, upper_bound):
        gamma += (((-1)**k)/math.factorial(k)*(z**(s+k))/(s+k))
    return gamma

###############################################################################

def complete_gamma(x):
    '''
    Returns the complete Gamma function as a function of x (degrees of freedom/2).
    An upper_bound and dt of 100.0 and 1e-4 are sufficient to ensure good resolution
    of the calculated Gamma value
    (i.e. good to 15 decimal places or more).
    '''

    upper_bound = 100
    dt = 1e-4

    time = 0
    Gamma = 0

    while time <= upper_bound:
        Gamma += dt*(time**(x-1)*math.exp(1)**(-time))
        time += dt

    return Gamma


###############################################################################


def chi_squared_cdf(x, k):
    '''
    Returns cumulative distribution function CDF (i.e. the p-value) of a Chi-squared test statistic,
    based on the Gamma function complete_gamma(x) and the incomplete lower gamma function
    incomplete_lower_gamma(s,z).
    Use in conjunction with chi_squared(observed_values, num_cats).
    '''

    return 1-incomplete_lower_gamma(k/2, x/2)/complete_gamma(k/2)


###############################################################################



def main(argv):
    '''
Calculates the Chi-squared test statistic for a nominally uniformly-distributed dataset.
Accepts as argument a pandas.core.series.Series or a list, and a value of categories/bins
(for nominally monthly data, num_cats = 12).
Also returns the cumulative distribution function CDF (i.e. the p-value) of the test statistic.
Requires chi_squared_cdf function.

Usage:
    chi_squared.py observed_values num_cats
    chi_squared 1,2,3,4,5 12
'''
    try:
        observed_values = ast.literal_eval(sys.argv[1])
        num_cats = ast.literal_eval(sys.argv[2])

    except:
        print('''
    Calculates the Chi-squared test statistic for a nominally uniformly-distributed dataset.
    Accepts as argument a pandas.core.series.Series or a list, and a value of categories/bins
    (for nominally monthly data, num_cats = 12).
    Also returns the cumulative distribution function CDF (i.e. the p-value) of the test statistic.
    Requires chi_squared_cdf function.

    Usage:
        chi_squared.py observed_values num_cats
        chi_squared 1,2,3,4,5 12
    ''')
        sys.exit()

    # observed_values = ast.literal_eval(argv[1])
    # num_cats = ast.literal_eval(argv[2])
    counts = Counter()

    for j in observed_values:
        counts[j] += 1

    for key in range(1, num_cats+1):
        if not key in counts.keys():
            counts[key] = 0
    for key in counts.keys():
        if not isinstance(key, numbers.Real):
            raise ValueError(
                'Key "{}" is type {}: integer or float required'.format(key, type(key)))
        if key not in range(1, num_cats+1):
            raise ValueError('Key "{}" out of range 1 - {}'.format(key, num_cats))
    
    prob_exp = []
    days_in_month = [31,28.25,31,30,31,30,31,31,30,31,30,31]
    prob_exp.append([ x/365.25 for x in days_in_month ])
    freq_exp = [ x*sum(counts.values()) for x in prob_exp[0] ]

    test_statistic = 0
    for key in counts.keys():
        freq_obs = counts[key]
        test_statistic += ((freq_obs - freq_exp[int(key)-1])**2)/freq_exp[int(key)-1]

    dof = len(counts.values())-1
    print(sys.argv[1:])
    print('\u03C72 = {:0.2f}; p = {:0.3f}'.format(
        test_statistic,
        chi_squared_cdf(test_statistic, dof)))
#return test_statistic, chi_squared_cdf(test_statistic, dof)

###############################################################################

if __name__ == "__main__":
    main(sys.argv[1:])
