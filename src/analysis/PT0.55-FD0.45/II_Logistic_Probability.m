function [p] = II_Logistic_Probability(x, beta, c)

p = 1./(1 + exp(-(c+ beta.*x)));
end