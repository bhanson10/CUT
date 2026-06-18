function T = isserlis_theorem(M, S)
% Description: 
%   Uses Isserlis' theorem to generate the analytical Mth order tensor for 
%   a Gaussian random variable with covariance S
%
% Inputs: 
%   M : order (nonnegative integer)
%   S : covariance, NxN
%
% Outputs:
%   T : N x N x ... x N (M times) central moment tensor 
% 
% Example:
%   S = [1 0; 0 1]; M4 = isserlis_theorem(4, S),

    % --- input checks
    if ~isscalar(M) || M<0 || M~=floor(M)
        error('M must be a nonnegative integer.');
    end
    [N1,N2] = size(S);
    if N1 ~= N2
        error('Sigma must be square.');
    end
    N = N1;
    
    % M == 0: return scalar 1
    if M == 0
        T = 1;
        return
    end
    
    % odd order => zero tensor
    if mod(M,2) == 1
        T = zeros(repmat(N,1,M));
        return
    end
    
    % Generate all perfect pairings of indices 1:M
    pairings = gen_pairings(1:M);
    
    % Initialize accumulator
    T = zeros(repmat(N,1,M));
    
    % For each pairing, build contribution tensor and add
    for pidx = 1:numel(pairings)
        pairs = pairings{pidx};   % nPairs x 2 array
        % start with ones tensor of shape N x ... x N (M dims)
        C = ones(repmat(N,1,M));
        % For each pair (a,b) multiply along axes a and b by Sigma
        for k = 1:size(pairs,1)
            a = pairs(k,1);
            b = pairs(k,2);
            % permute so that axes [a,b,others...] => [1,2,3...]
            perm = [a b setdiff(1:M,[a b],'stable')];
            Cperm = permute(C, perm);
            sz = size(Cperm);
            % reshape to (N x N x N^(M-2))
            if M==2
                resh = Cperm; % size N x N
                % multiply entire matrix elementwise by Sigma
                resh = resh .* S;
                Cperm = resh;
            else
                resh = reshape(Cperm, N, N, []);
                % For each slice multiply by Sigma elementwise
                % (there are N^(M-2) slices)
                nslices = size(resh,3);
                for s = 1:nslices
                    resh(:,:,s) = resh(:,:,s) .* S;
                end
                Cperm = reshape(resh, sz);
            end
            % inverse permute back to original axis order
            C = ipermute(Cperm, perm);
        end
        % add this pairing contribution
        T = T + C;
    end
end

function pairings = gen_pairings(labels)
    % returns a cell array where each element is an nPairs x 2 array of pairs
    % labels: row vector of integers (e.g. 1:M)
    if isempty(labels)
        pairings = {zeros(0,2)}; % one pairing: empty
        return
    end
    
    labels = labels(:).'; % ensure row
    n = numel(labels);
    if mod(n,2)==1
        pairings = {}; % no perfect pairing
        return
    end
    
    % recursive construction: pair first label with each other label
    first = labels(1);
    pairings = {};
    for j = 2:n
        partner = labels(j);
        rest = labels(2:end);
        rest(j-1) = []; % remove partner from rest
        subPairings = gen_pairings(rest);
        for k = 1:numel(subPairings)
            sub = subPairings{k};
            % prepend the pair [first partner]
            newpair = [[first partner]; sub];
            pairings{end+1} = newpair; %#ok<AGROW>
        end
    end
end