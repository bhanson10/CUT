clear all; close all; clc; format long;

%% 2D parameters
mu = [1; 2]; S = [2 0.4; 0.4 1];

%% CUT4 demo
fprintf("2D CUT4 results:\n")
[Z, W] = cut4(mu, S); 

W,
Z,

fprintf("2D CUT6 results:\n")
[Z, W] = cut6(mu, S); 

W,
Z,