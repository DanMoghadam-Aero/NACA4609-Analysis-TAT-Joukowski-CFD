clc; clear; close all;


naca_digit= '4609';  % Enter desired NACA 4 digit airfoil

%% 1. Parameters (Equivalent to NACA 4609)
h = str2double(naca_digit(1))/100;           % Camber Ratio
t = str2double(naca_digit(3:4))/100;    % Airfoil Thickness
V_inf = 1.0;        % non-dimensional freestream velocity
a = 1;              % characteristic length

%% 2. Transformation Offsets
epsilon = -a * (4 / (3 * sqrt(3))) * t; 
h = 2 * a * h; 
zeta_c = epsilon + 1i * h; 
R = sqrt((a - epsilon)^2 + h^2);
beta = asin(h / R); 

%% 3. Lift Coefficient Sweep (0 to 20 degrees)
alpha_deg_sweep = 0:1:20;
cl_sweep = zeros(size(alpha_deg_sweep));
chord = 4 * a; % Normalization approximation

for i = 1:length(alpha_deg_sweep)
    alpha_rad = deg2rad(alpha_deg_sweep(i));
    Gamma_sweep = 4 * pi * V_inf * R * sin(alpha_rad + beta);
    cl_sweep(i) = (2 * Gamma_sweep) / (V_inf * chord);
end

%% 4. Single Alpha Geometry & Pressure (e.g., 5 degrees)
alpha_cp_deg = 1; % Angle of Attack for Pressure Distribution
alpha_cp_rad = deg2rad(alpha_cp_deg);

% eps to avoid dividing byvzero at the trailing edge
theta = linspace(eps, 2*pi-eps, 300)';
zeta = zeta_c + R * exp(1i * theta);
z = zeta + (a^2) ./ zeta;

Gamma_cp = 4 * pi * V_inf * R * sin(alpha_cp_rad + beta);
dW_dzeta = V_inf * exp(-1i * alpha_cp_rad) - V_inf * (R^2) * exp(1i * alpha_cp_rad) ./ ((zeta - zeta_c).^2) + 1i * Gamma_cp ./ (2 * pi * (zeta - zeta_c));
dz_dzeta = 1 - (a^2) ./ (zeta.^2);
V_z = dW_dzeta ./ dz_dzeta;

Cp = 1 - (abs(V_z) / V_inf).^2;

x_c = real(z);
x_c = (x_c - min(x_c)) / (max(x_c) - min(x_c));
upper_idx = (theta <= pi);
lower_idx = (theta >= pi);

%% 5. Plotting (3-Panel Layout)
figure('Name', 'Comprehensive Joukowsky Analysis', 'Position', [100, 100, 1200, 400]);

% #1 Panel>> Airfoil Geometry & Complex Circle
subplot(1,3,1);
plot(real(zeta), imag(zeta), 'b--', 'LineWidth', 1.5); hold on;
plot(real(z), imag(z), 'k', 'LineWidth', 1.5);
plot(real(zeta_c), imag(zeta_c), 'rx', 'MarkerSize', 8, 'LineWidth', 2); 
plot(a, 0, 'ro', 'MarkerSize', 8, 'LineWidth', 2); 
hold off;
axis equal; grid on;
title('Conformal Mapping',sprintf(' NACA %s',naca_digit), 'Interpreter', 'latex');
xlabel('Real Axis', 'Interpreter', 'latex'); ylabel('Imaginary Axis', 'Interpreter', 'latex');
legend('Cylinder', 'Airfoil', 'Cylinder Center', 'Kutta Point', 'Location', 'northeast');

% #2 Panel>> Lift Curve
subplot(1,3,2);
plot(alpha_deg_sweep, cl_sweep, 'b-', 'LineWidth', 1.5);
grid on;
title('$C_l$ vs $\alpha$', 'Interpreter', 'latex');
xlabel('$\alpha$ (degrees)', 'Interpreter', 'latex'); ylabel('$C_l$', 'Interpreter', 'latex');
legend(sprintf(' NACA %s',naca_digit), 'Location','northeast')

% #3 Panel>> Pressure Distribution
subplot(1,3,3);
plot(x_c(lower_idx), Cp(lower_idx), 'b', 'LineWidth', 1.5); hold on;
plot(x_c(upper_idx), Cp(upper_idx), 'r', 'LineWidth', 1.5);
yline(1, 'k--', 'LineWidth', 1.5, 'Alpha', 0.5); hold off;
set(gca, 'YDir', 'reverse');
ylim([-4 1.5]); grid on;
title(['Pressure Distribution ($\alpha = ' num2str(alpha_cp_deg) '^\circ$)', sprintf(', NACA %s',naca_digit)], 'Interpreter', 'latex');
xlabel('x/c', 'Interpreter', 'latex'); ylabel('$C_p$', 'Interpreter', 'latex');
legend('Lower', 'Upper', '$C_p = 1$', 'Interpreter', 'latex', 'Location', 'best');