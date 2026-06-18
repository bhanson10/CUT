clear all; close all; clc; format shortG;

%% parameters
load("colors.mat"); 
mu_s = [0; 1]; S_s = [0.01 0; 0 0.01]; N = 2; 

% trajectory
tspan = [0 100]; % propagate from t=0 to t=100
[~, Xs] = ode45(@(t,x) duffing(t,x), tspan, mu_s);

% mc
Nmc = 5000; 
X0 = mvnrnd(mu_s, S_s, Nmc); 

% CUT
[Z0, W] = CUT6(mu_s, S_s); n = size(Z0, 1); 

% plotting
figure("Position", [348,206,784,604]); 
tiledlayout(1, 1, "TileSpacing", "compact"); nexttile(1); hold on; box on;
set(gca, 'FontName', 'times', 'FontSize', 18, "LineWidth", 2);  
scatter(X0(:, 1), X0(:, 2), 50, 'filled', 'MarkerFaceColor', [0.7 0.7 0.7], 'MarkerFaceAlpha', 0.25);
scatter(Z0(:, 1), Z0(:, 2), 100, 'd', 'filled', 'MarkerFaceColor', hanred);

% % Edgeworth expansion
% mu = reconstruct_CUT(Z0, W, 1, 4); % 1) first central moment (mean)   
% S  = reconstruct_CUT(Z0, W, 2, 4); % 2) second central moment (covariance)
% M3 = reconstruct_CUT(Z0, W, 3, 4); % 3) third central moment 
% M4 = reconstruct_CUT(Z0, W, 4, 4); % 4) fourth central moment
% K3 = moment2cumulant(S, M3);
% K4 = moment2cumulant(S, M4);
% [X1, X2, P] = edgeworth2D(mu, S, K3, K4, 50, 50); 
% X = [X1(:) X2(:)]; P = P(:); 

% Principle of maximum entropy
M = 6; % up to 4th order
[X, P] = pme_cut2pdf(Z0, W, 'M', M); 

p.lw = 3; p.ls = "-"; p.color = hangreen; 
plot_nongaussian_surface(X, 'P', P, 'p', p);
p.ls = "-."; p.color = hanred; 
plot_gaussian_ellipsoid(mu_s, S_s, 'sd', 3, 'p', p); 
plot(Xs(:, 1), Xs(:, 2), "g-", "LineWidth", 1);
drawnow; 

for tend = [1, 2.5, 5]
    tspan = [0 tend]; % propagate from t=0 to t=1.5
    [~, Xt] = ode45(@(t,x) duffing(t,x), tspan, mu_s);
    plot(Xt(:, 1), Xt(:, 2), "k-", "LineWidth", 2);

    Xf = zeros(Nmc, 2); % store propagated states
    for i = 1:Nmc
        [~, Xi] = ode45(@(t,x) duffing(t,x), tspan, X0(i,:)');
        Xf(i, :) = Xi(end, :); 
    end
    scatter(Xf(:, 1), Xf(:, 2), 50, 'filled', 'MarkerFaceColor', [0.7 0.7 0.7], 'MarkerFaceAlpha', 0.25);
    
    Zf = zeros(n, 2); % store propagated states
    for i = 1:n
        [~, Zi] = ode45(@(t,x) duffing(t,x), tspan, Z0(i,:)');
        Zf(i, :) = Zi(end, :); 
    end
    scatter(Zf(:, 1), Zf(:, 2), 100, 'd', 'filled', 'MarkerFaceColor', hanred);
   
    % % Edgeworth expansion
    % mu = reconstruct_CUT(Zf, W, 1, 4); % 1) first central moment (mean)   
    % S  = reconstruct_CUT(Zf, W, 2, 4); % 2) second central moment (covariance)
    % M3 = reconstruct_CUT(Zf, W, 3, 4); % 3) third central moment 
    % M4 = reconstruct_CUT(Zf, W, 4, 4); % 4) fourth central moment
    % K3 = moment2cumulant(S, M3);
    % K4 = moment2cumulant(S, M4);
    % [X1, X2, P] = edgeworth2D(mu, S, K3, K4, 50, 50); 
    % X = [X1(:) X2(:)]; P = P(:); 

    % Principle of Maximum Entropy
    mu = reconstruct_CUT(Zf, W, 1, 4); % 1) first central moment (mean)   
    S  = reconstruct_CUT(Zf, W, 2, 4); % 2) second central moment (covariance)
    [X, P] = pme_cut2pdf(Zf, W, 'M', M); 

    p.ls = "-."; p.color = hanred; 
    plot_gaussian_ellipsoid(mu, S, 'sd', 3, 'p', p); 
    p.ls = "-"; p.color = hangreen; 
    plot_nongaussian_surface(X, 'P', P, 'p', p);
    drawnow; 
end

% legend
LH(1) = scatter(nan, nan, 100, 'o', 'MarkerFaceColor', [0.7 0.7 0.7], 'MarkerEdgeColor', 'none');
L{1} = "MC $(n=$ " + num2str(Nmc) + "$)$";
LH(2) = scatter(nan, nan, 100, 'filled', 'd', 'filled', 'MarkerFaceColor', hanred, 'MarkerEdgeColor', 'none');
L{2} = "CUT6 $(N=$ " + num2str(numel(W)) + "$)$";
LH(3) = plot(nan, nan,  "Color", hanred, "LineStyle", "-.", "LineWidth", 2);
L{3} = "$\mathcal{N}(\hat{x},P)$";
% LH(4) = plot(nan, nan,  "Color", hangreen, "LineWidth", 2);
% L{4} = "Edgeworth expansion (4th-order)";
LH(4) = plot(nan, nan,  "Color", hangreen, "LineWidth", 2);
L{4} = "PME ($M=6$)";
leg = legend(LH, L, "FontSize", 18, "FontName", "times", "Interpreter", "latex",...
             "LineWidth", 1, "Orientation", "horizontal");
leg.Layout.Tile = 'south'; 
xlim([-1.75, 1.75]); ylim([-1.25, 1.5]); 

text(-0.13671875,0.5369211514393, "$t=0$", "FontSize", 20, "Interpreter", "latex");
text(0.8818359375,0.764080100125156, "$t=1$", "FontSize", 20, "Interpreter", "latex");
text(0.765625,-0.619524405506883, "$t=2.5$", "FontSize", 20, "Interpreter", "latex");
text(-0.8203125,-0.998122653316646, "$t=5$", "FontSize", 20, "Interpreter", "latex");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dx = duffing(t, x)
    a = 0.35; b = 0.3; w = 1; 
    dx = zeros(2, 1); 
    dx(1) = x(2); 
    dx(2) = x(1) - x(1)^3 - a * x(2) + b * cos(w * t); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
