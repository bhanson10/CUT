clear all; close all; clc; format long;

%% 2D parameters
tol = 1e-10;
mu = [0; 0]; S = [1 0; 0 1];

%% CUT4 demo
fprintf("2D CUT4 results:\n\n")
[Z, W] = CUT4(mu, S); 

% E[x_i^2] = 1
count = 1; 
for i = 1:size(Z, 2)
    sum = 0;
    for n = 1:size(Z, 1)
        sum = sum + W(n) * Z(n, i)^2; 
    end
    sums(count) = sum; count = count + 1; 
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^2] = 1\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^2] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^2]\n\n");
end


% E[x_i*x_j] = 0
clear sums; count = 1; 
for i = 1:size(Z, 2)
    sum = 0;
    for j = 1:size(Z, 2)
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i) * Z(n, j); 
            end
            sums(count) = sum; count = count + 1; 
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i*x_j] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i*x_j] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i*x_j]\n\n");
end

% E[x_i^4] = 3
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for n = 1:size(Z, 1)
        sum = sum + W(n) * Z(n, i)^4; 
    end
    sums(count) = sum; count = count + 1; 
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^4] = 3\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^4] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^4]\n\n");
end

% E[x_i^3*x_j] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for j = 1:size(Z, 2)
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i)^3 * Z(n, j); 
            end
            sums(count) = sum; count = count + 1; 
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^3*x_j] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^3*x_j] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^3*x_j]\n\n");
end

% E[x_i^2*x_j^2] = 1
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for j = 1:size(Z, 2)
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i)^2 * Z(n, j)^2; 
            end
            sums(count) = sum; count = count + 1; 
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^2*x_j^2] = 1\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^2*x_j^2] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^2*x_j^2]\n\n");
end

%% CUT6 demo
fprintf("\n2D CUT6 results:\n\n")
[Z, W] = CUT6(mu, S); 

% E[x_i^2] = 1
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for n = 1:size(Z, 1)
        sum = sum + W(n) * Z(n, i)^2; 
    end
    sums(count) = sum; count = count + 1; 
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^2] = 1\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^2] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^2]\n\n");
end

% E[x_i*x_j] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for j = 1:size(Z, 2)
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i) * Z(n, j); 
            end
            sums(count) = sum; count = count + 1;  
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i*x_j] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i*x_j] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i*x_j]\n\n");
end

% E[x_i^4] = 3
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for n = 1:size(Z, 1)
        sum = sum + W(n) * Z(n, i)^4; 
    end
    sums(count) = sum; count = count + 1; 
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^4] = 3\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^4] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^4]\n\n");
end

% E[x_i^3*x_j] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for j = 1:size(Z, 2)
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i)^3 * Z(n, j); 
            end
            sums(count) = sum; count = count + 1; 
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^3*x_j] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^3*x_j] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^3*x_j]\n\n");
end

% E[x_i^2*x_j^2] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for j = 1:size(Z, 2)
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i)^2 * Z(n, j)^2; 
            end
            sums(count) = sum; count = count + 1; 
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^2*x_j^2] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^2*x_j^2] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^2*x_j^2]\n\n");
end

%% 4D parameters
mu = [0; 0; 0; 0]; S = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];

%% CUT6 demo
fprintf("\n4D CUT6 results:\n\n")
[Z, W] = CUT6(mu, S); 

% E[x_i^2] = 1
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for n = 1:size(Z, 1)
        sum = sum + W(n) * Z(n, i)^2; 
    end
    sums(count) = sum; count = count + 1; 
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^2] = 1\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^2] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^2]\n\n");
end

% E[x_i*x_j] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for j = 1:size(Z, 2)
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i) * Z(n, j); 
            end
            sums(count) = sum; count = count + 1; 
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i*x_j] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i*x_j] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i*x_j]\n\n");
end

% E[x_i^4] = 3
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for n = 1:size(Z, 1)
        sum = sum + W(n) * Z(n, i)^4; 
    end
    sums(count) = sum; count = count + 1; 
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^4] = 3\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^4] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^4]\n\n");
end

% E[x_i^3*x_j] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for j = 1:size(Z, 2)
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i)^3 * Z(n, j); 
            end
            sums(count) = sum; count = count + 1;  
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^3*x_j] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^3*x_j] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^3*x_j]\n\n");
end

% E[x_i^2*x_j^2] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    for j = 1:size(Z, 2)
        sum = 0;
        if i ~= j
            for n = 1:size(Z, 1)
                sum = sum + W(n) * Z(n, i)^2 * Z(n, j)^2; 
            end
            sums(count) = sum; count = count + 1; 
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^2*x_j^2] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^2*x_j^2] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^2*x_j^2]\n\n");
end

% E[x_i^2*x_j*x_k] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    for j = 1:size(Z, 2)
        for k = 1:size(Z, 2)
            sum = 0; x = [i, j, k]; 
            if numel(unique(x)) == numel(x)
                for n = 1:size(Z, 1)
                    sum = sum + W(n) * Z(n, i)^2 * Z(n, j) * Z(n, k); 
                end
                sums(count) = sum; count = count + 1; 
            end
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^2*x_j*x_k] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^2*x_j*x_k] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^2*x_j*x_k]\n\n");
end

% E[x_i*x_j*x_k*x_l] = 0
clear sums; count = 1;
for i = 1:size(Z, 2)
    for j = 1:size(Z, 2)
        for k = 1:size(Z, 2)
            for l = 1:size(Z, 2)
                sum = 0; x = [i, j, k, l]; 
                if numel(unique(x)) == numel(x)
                    for n = 1:size(Z, 1)
                        sum = sum + W(n) * Z(n, i) * Z(n, j) * Z(n, k) * Z(n, l); 
                    end
                    sums(count) = sum; count = count + 1;  
                end
            end
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i*x_j*x_k*x_l] = 0\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i*x_j*x_k*x_l] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i*x_j*x_k*x_l]\n\n");
end

% E[x_i^2*x_j^2*x_k^2] = 1
clear sums; count = 1;
for i = 1:size(Z, 2)
    for j = 1:size(Z, 2)
        for k = 1:size(Z, 2)
            sum = 0; x = [i, j, k]; 
            if numel(unique(x)) == numel(x)
                for n = 1:size(Z, 1)
                    sum = sum + W(n) * Z(n, i)^2 * Z(n, j)^2 * Z(n, k)^2; 
                end
                sums(count) = sum; count = count + 1; 
            end
        end
    end
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^2*x_j^2*x_k^2] = 1\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^2*x_j^2*x_k^2] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^2*x_j^2*x_k^2]\n\n");
end

% E[x_i^6] = 15
clear sums; count = 1;
for i = 1:size(Z, 2)
    sum = 0;
    for n = 1:size(Z, 1)
        sum = sum + W(n) * Z(n, i)^6; 
    end
    sums(count) = sum; count = count + 1; 
end
sums = sort(sums(:)); fprintf("Size: " + num2str(count - 1) + "\n"); 
fprintf("E[x_i^6] = 15\n");
if all(diff(sums) < tol)
    fprintf("Actual[x_i^6] = %f\n\n", sums(1));
else
    fprintf("ERROR: E[x_i^6]\n\n");
end