function [Z, W] = cut6(mu, S)
% Description: 
%   The 6th order conjugate unscented transform sigma points and weights
%   for dimenions 2 <= N <= 9, with mean mu and covariance S
%
% Inputs: 
%   mu : mean, Nx1
%   S : covariance, NxN
%
% Outputs:
%   Z : conjugate unscented transform sigma points, 
%   W : conjugate unscented transform weights
% 
% Example:
%   mu = [2; 3]; S = [6 2; 2 4];
%   [Z, W] = CUT6(mu, S); figure; hold on; scatter(Z(:, 1), Z(:, 2), 100, 'filled');
%   mu = W' * Z, S = (Z - mu)' * ((Z - mu) .* W),
%   plot_gaussian_ellipsoid(mu', S, 'sd', 3); 

% Constants by dimension
%    2D           3D           4D           5D           6D           7D           8D           9D 
r = [2.4494897427 2.3587090379 2.2520650012 2.1213203430 1.9488352799 2.5512003554 2.4494897427 2.3439068809;  % r1
     1.1147379454 1.1198362859 1.1260325006 1.1338934189 1.1445968942 0.9642630978 0.9999999999 1.0232621870;  % r2
     3.2004125801 3.1421303838 3.0763780026 3.0000000003 2.9068006056 2.3255766977 2.4494897428 2.5342865662]; % r3
w = [0.3658770242 0.3124789714 0.2499999999 0.1728395055 0.0674637121 0.0896488470 0.0740740740 0.0421898530;  % w0
     0.0277777777 0.0290351301 0.0306601632 0.0329218107 0.0365072564 0.0126940628 0.0138888888 0.0150764081;  % w1
     0.1302876649 0.0633844605 0.0306601632 0.0147033607 0.0069487173 0.0048594459 0.0023437500 0.0011342720;  % w2
     0.0004653012 0.0005195469 0.0005898367 0.0006858710 0.0008288549 0.0003950899 0.0002314814 0.0001572730]; % w3

N = numel(mu); 
if N < 2
    error("Dimension must not be below 2."); 
elseif N <= 6
    n = 2 * N^2 + 2^N + 1; 
elseif N <= 9
    n = 2 * N + 2^N + (4 * N * (N - 1) * (N - 2) / 3) + 1; 
else
    error("Dimension must not be above 9."); 
end

Z = nan(n, N); 
W = nan(n, 1); 

s  = principal_points(N);
cN = conj_N_points(N);
Z(1, :) = zeros(1, N); W(1) = w(1, N - 1); last_idx = 1;
Z(last_idx + 1:last_idx + 2 * N, :) = r(1, N - 1) .* s; W(last_idx + 1:last_idx + 2 * N) = w(2, N - 1); last_idx = last_idx + 2 * N; 
Z(last_idx + 1:last_idx + 2^N, :) = r(2, N - 1) .* cN; W(last_idx + 1:last_idx + 2^N) = w(3, N - 1); last_idx = last_idx + 2^N; 
if N <= 6
    c2 = conj_M_points(N, 2); 
    Z(last_idx + 1:last_idx + 2 * N * (N - 1), :) = r(3, N - 1) .* c2; W(last_idx + 1:last_idx + 2 * N * (N - 1)) = w(4, N - 1); 
else
    c3 = conj_M_points(N, 3); 
    Z(last_idx + 1:last_idx + (4 * N * (N - 1) * (N - 2) / 3), :) = r(3, N - 1) .* c3; W(last_idx + 1:last_idx + (4 * N * (N - 1) * (N - 2) / 3)) = w(4, N - 1);
end

Z = Z * sqrtm(S) + mu'; 
end