clear all; close all; clc; format long; 

%% parameters
load("colors.mat"); 
mu = [0; 0]; S = [1 0; 0 1]; N = 2; 
load("colors.mat"); 

%% CUT4 demo
disp("CUT4 results:")
[Z, W] = cut4(mu, S);

f1 = figure(1); clf; f1.Position = [250, 250, 1300, 600]; 
tiledlayout(1, 2, "Padding", "compact"); 
nexttile(1); hold on; box on;
set(gca, 'FontName', 'Times','FontSize', 24, "LineWidth", 2); 
leg = legend(gca, 'Orientation', 'Horizontal', 'FontSize', 24, ...
             'FontName', 'times', 'Interpreter', 'latex', "LineWidth", 2);
leg.Layout.Tile = 'north'; 
xlabel("$x$", "Interpreter", "latex", "FontSize", 32);
ylabel("$y$", "Interpreter", "latex", "FontSize", 32);
scatter(Z(:, 1), Z(:, 2), 300, 'filled', "d", "MarkerFaceColor", hanred, "DisplayName", "CUT sigma points");
p.name = "CUT-reconstructed $3\sigma$";
plot_gaussian_ellipsoid(mu, S, "p", p); 
xlim([-3.5, 3.5]); ylim([-3.5, 3.5]); axis equal; 

% numerical/analytical calculations
M1_n = reconstruct_cut(Z, W, 1, 4), % 1) first central moment 
M2_n = reconstruct_cut(Z, W, 2, 4), % 2) second central moment 
M3_n = reconstruct_cut(Z, W, 3, 4), % 3) third central moment 
M3_a = isserlis_theorem(3, S), % 3) third central moment 
M4_n = reconstruct_cut(Z, W, 4, 4), % 4) fourth central moment
M4_a = isserlis_theorem(4, S), % 4) fourth central moment 

%% CUT6 demo
disp("CUT6 results:")
[Z, W] = cut6(mu, S); 

nexttile(2); hold on; box on; 
set(gca, 'FontName', 'Times','FontSize', 24, "LineWidth", 2); 
xlabel("$x$", "Interpreter", "latex", "FontSize", 32);
ylabel("$y$", "Interpreter", "latex", "FontSize", 32);
scatter(Z(:, 1), Z(:, 2), 300, 'filled', "d", "MarkerFaceColor", hanred);
plot_gaussian_ellipsoid(mu, S, "p", p);
xlim([-3.5, 3.5]); ylim([-3.5, 3.5]); axis equal; 

% numerical/analytical calculations
M1_n = reconstruct_cut(Z, W, 1, 6), % 1) first central moment 
M2_n = reconstruct_cut(Z, W, 2, 6), % 2) second central moment 
M3_n = reconstruct_cut(Z, W, 3, 6), % 3) third central moment 
M3_a = isserlis_theorem(3, S), % 3) third central moment 
M4_n = reconstruct_cut(Z, W, 4, 6), % 4) fourth central moment 
M4_a = isserlis_theorem(4, S), % 4) fourth central moment 