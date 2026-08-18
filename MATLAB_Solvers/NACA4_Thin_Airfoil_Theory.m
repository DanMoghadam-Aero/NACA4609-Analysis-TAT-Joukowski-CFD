% analyze_NACA4 - Computes airfoil properties using Thin Airfoil Theory

clc;
clear all;

%% 0. Airfoil Input
naca_digits='4612'; % Enter your desired NACA 4_digit Airfoil inside 'XXXX'
cp_alpha= 5;        % Enter your desired angle of attack for C_p (in degrees)


%% 1. Extract Airfoil Parameters
M = str2double(naca_digits(1)) / 100;
P = str2double(naca_digits(2)) / 10;
XX = str2double(naca_digits(3:4)) / 100;

%% 2. Generate Coordinates & Airfoil Shape
x = linspace(0, 1, 101)';
yc = zeros(size(x));
dzc_dx = zeros(size(x));

if P > 0
    front = (x <= P); back = (x > P);
    yc(front) = (M / P^2) * (2 * P * x(front) - x(front).^2);
    yc(back) = (M / (1 - P)^2) * (1 - 2 * P + 2 * P * x(back) - x(back).^2);
    dzc_dx(front) = (2 * M / P^2) * (P - x(front));
    dzc_dx(back) = (2 * M / (1 - P)^2) * (P - x(back));
end

a0 = 0.2969; a1 = -0.126; a2 = -0.3516; a3 = 0.2843; a4 = -0.1036;
yt = (XX / 0.2) * (a0 * sqrt(x) + a1 * x + a2 * x.^2 + a3 * x.^3 + a4 * x.^4);

theta_surf = atan(dzc_dx);
xu = x - yt .* sin(theta_surf); yu = yc + yt .* cos(theta_surf);
xl = x + yt .* sin(theta_surf); yl = yc - yt .* cos(theta_surf);

%% 3. Thin Airfoil Theory Coefficients
theta_G = acos(1 - 2 * x);
w1 = -(1/pi) * trapz(theta_G, dzc_dx);
A1 = (2/pi) * trapz(theta_G, dzc_dx .* cos(theta_G));
A2 = (2/pi) * trapz(theta_G, dzc_dx .* cos(2 * theta_G));

alpha_deg = 0:1:20;
alpha_rad = deg2rad(alpha_deg);
A0 = alpha_rad + w1;

cl = 2 * pi * (A0 + 0.5 * A1);
cm_le = -(0.5 * pi) * (A0 + A1 - 0.5 * A2);

%% 4. Pressure Coefficient
theta_cp = linspace(eps, pi-eps, 100)';
x_cp = 0.5 * (1 - cos(theta_cp));

A0_cp = deg2rad(cp_alpha) + w1;
Cp_u = -2. * ((A0_cp + A0_cp * cos(theta_cp)) ./ sin(theta_cp)) - 2 * A1 * sin(theta_cp) - 2 * A2 * sin(2 * theta_cp);
Cp_l =  2. * ((A0_cp + A0_cp * cos(theta_cp)) ./ sin(theta_cp)) + 2 * A1 * sin(theta_cp) + 2 * A2 * sin(2 * theta_cp);

%% 5. Workspace View
results.x = x; results.yc = yc; results.dyc_dx = dzc_dx; results.yt = yt;
results.xu = xu; results.yu = yu; results.xl = xl; results.yl = yl;
results.alpha_deg = alpha_deg; results.cl = cl; results.cm_le = cm_le;
results.A0 = A0; results.A1 = A1; results.A2 = A2;
results.x_cp = x_cp; results.Cp_u = Cp_u; results.Cp_l = Cp_l;

%% 6. Plotting
figure('Name', ['NACA ' naca_digits ' Analysis'], 'Position', [100, 100, 900, 700]);

% Airfoil Plot
subplot(2,2,1);
plot(x, yc, 'r--', xu, yu, 'k', xl, yl, 'k', 'LineWidth', 1.5);
axis equal; grid on; title(['Airfoil Shape NACA ' naca_digits]);
legend('Camber Line', 'Airfoil Boundary', 'Location','northeast')

% Lift Plot
subplot(2,2,2);
plot(alpha_deg, cl, 'b-', 'LineWidth', 1.5);
grid on; title('$C_l$ vs $\alpha$', 'Interpreter', 'latex');
xlabel('$\alpha$ (degrees)', 'Interpreter', 'latex'); ylabel('$C_l$', 'Interpreter', 'latex');

% Moment Plot
subplot(2,2,3);
plot(alpha_deg, cm_le, 'm-', 'LineWidth', 1.5);
grid on; title('$C_{m,le}$ vs $\alpha$', 'Interpreter', 'latex');
xlabel('$\alpha$ (degrees)', 'Interpreter', 'latex'); ylabel('$C_{m,le}$', 'Interpreter', 'latex');

% Pressure Coefficient Plot
subplot(2,2,4);
plot(x_cp, Cp_l, 'b', 'LineWidth', 1.5); hold on;
plot(x_cp, Cp_u, 'r', 'LineWidth', 1.5);
yline(1, 'k--', 'LineWidth', 1.5, 'Alpha', 0.5); % Stagnation Limit Line
hold off;

set(gca, 'YDir', 'reverse');
grid on;
ylim([-4 4]);

title(['Pressure Distribution at $\alpha = ' num2str(cp_alpha) '^\circ$'], 'Interpreter', 'latex');
xlabel('x/c'); ylabel('$C_p$', 'Interpreter', 'latex');
legend('Lower Surface', 'Upper Surface', 'Max Physical Limit (C_p = 1)', 'Location', 'best');
