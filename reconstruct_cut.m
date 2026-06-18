function out = reconstruct_cut(Z, W, M1, M2)
% Description: 
%   Reconstruct central moment of order M from CUT sigma points
%
% Inputs:
%   Z : n x N matrix of sigma points (rows = points, columns = state dim)
%   W : n x 1 vector of weights
%   M1 : integer >=1, order of central moment to reconstruct
%       1 => mean, 2 => covariance, 3+ => Mth central moment tensor
%   M2 : order of CUT used
%
% Output:
%   out - depends on M:
%       M=1: N x 1 mean vector
%       M=2: N x N covariance matrix
%       M>=3: N x ... x N tensor with M dimensions

[n, N] = size(Z);
if M1 < 1 || M1 > M2 || M1 ~= floor(M1)
    error('M must be an integer between 1 and the CUT order.');
end
W = W(:);  % ensure column

% center Z if M>=2
mu = Z.' * W;           % N x 1
if M1 == 1
    out = mu;
    return
end
Zc = Z - mu.';          % n x N

if M1 == 2
    % covariance
    Zcw = Zc .* W;      % weight rows
    S = Zcw.' * Zc;     % N x N
    out = S;
    return
end

% M >= 3: compute M-th central moment tensor
dims = repmat(N,1,M1);
T = zeros(dims);
for i = 1:n
    v = Zc(i,:);
    T = T + W(i) * outerM(v, M1);
end

out = T;

end

function T = outerM(v, M)
% Recursive outer product of a vector v (1 x N) M times
v = v(:);   % column vector
d = numel(v);

if M == 1
    T = v;  % N x 1
else
    Tprev = outerM(v, M-1);          % size: N x ... x N (M-1 dims)
    % Expand Tprev to add a new dimension for v
    sz_prev = size(Tprev);
    % reshape v to 1 x 1 x ... x 1 x N (singleton dims + last dim)
    sz_v = ones(1, M); sz_v(end) = d;
    v_exp = reshape(v, sz_v);
    % Use implicit expansion (MATLAB 2016b+) to multiply elementwise
    T = Tprev .* v_exp;              % now N x ... x N (M dims)
end
end

