function [Z, W] = CUT4(mu, S)
% Description: 
%   The 5th order conjugate unscented transform sigma points and weights
%   for dimenions 1 <= N <= 2, with mean mu and covariance S
%
% Inputs: 
%   mu : mean, Nx1
%   S : covariance, NxN
%
% Outputs:
%   Z : conjugate unscented transform sigma points
%   W : conjugate unscented transform weights
% 
% Example:
%   mu = [2; 3]; S = [6 2; 2 4];
%   [Z, W] = CUT4(mu, S); figure; hold on; scatter(Z(:, 1), Z(:, 2), 100, 'filled');
%   mu = W' * Z, S = (Z - mu)' * ((Z - mu) .* W),
%   plot_gaussian_ellipsoid(mu', S, 'sd', 3); 

% Constants by dimension
%    1D                 2D           
r = [1.4861736616297834 2.6060099476935847;    % r1
     3.2530871022700643 1.190556300661233];    % r2
w = [0.5811010092660772 0.41553535186548973;   % w0
     0.20498484723245053 0.021681819434216532; % w1
     0.00446464813451093 0.12443434259941118]; % w2

N = numel(mu); 
if N < 1
    error("Dimension must not be below 1."); 
elseif N <= 2
    n = 2 * N + 2^N + 1; 
else
    error("Dimension must not be above 2."); 
end

Z = nan(n, N); 
W = nan(n, 1); 

s  = principal_points(N);
cN = conj_N_points(N);
Z(1, :) = zeros(1, N); W(1) = w(1, N); last_idx = 1;
Z(last_idx + 1:last_idx + 2 * N, :) = r(1, N) .* s; W(last_idx + 1:last_idx + 2 * N) = w(2, N); last_idx = last_idx + 2 * N; 
Z(last_idx + 1:last_idx + 2^N, :) = r(2, N) .* cN; W(last_idx + 1:last_idx + 2^N) = w(3, N); 

Z = Z * sqrtm(S) + mu'; 
end