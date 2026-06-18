function X = scaled_conj_N_points(N, h)
% Description: 
%   The scaled conjugate axis points s^N_i makes use of conj_N_points
%
% Inputs: 
%   N : dimension
%   h : scaling factor
%
% Outputs:
%   X : sigma points on scaled conjugate N axis, each row of the matrix X
%   corresponds to one sigma point, N2^NxN
% 
% Example: 
%   X = scaled_conj_N_points(3, 2),

D = conj_N_points(N); 
X = zeros(N * 2^N, N); 
A = zeros(2^N , N); 
i = 1; cnt = 1; 
for i = 1:N
    A = D; 
    A(:, i) = h .* A(:, i); 
    X(cnt:cnt + 2^N - 1, :) = A; 
    cnt = cnt + 2^N; 
end
end