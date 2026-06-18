clear all; close all; clc; format long;

%% parameters
opts = optimoptions('fsolve','Display','iter');

%% uniform distribution
a = 0; b = 10;
La = [log(1/(b - a))]; 
eqs = @(L) integral(@(x) exp(L).*ones(size(x)), a, b) - 1;
L = fsolve(eqs, zeros(numel(La), 1), opts);
fprintf("Uniform Distribution via PME:\n")
for i = 1:numel(L)
    fprintf("       L%d Expected: %.10f\n", i, L(i));
    fprintf("         L%d Actual: %.10f\n", i, La(i));
end

%% exponential distribution
l = 0.2;
La = [log(l), -l]; 
eqs = @(L) [
             integral(@(x) exp(L(1) + L(2)*x), 0, Inf) - 1;
             integral(@(x) x .* exp(L(1) + L(2)*x), 0, Inf) - (1/l)
           ];
L = fsolve(eqs, [log(l); -l], opts);

fprintf("Exponential Distribution via PME:\n")
for i = 1:numel(La)
    fprintf("       L%d Expected: %.10f\n", i, L(i));
    fprintf("         L%d Actual: %.10f\n", i, La(i));
end