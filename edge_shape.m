
clear all

syms l alpha real

func_length = 1/8 * l^2;

% r = 3;
% func_length = r * (1 - cos(l/r));

yCenter_on_alpha = func_length / tan(alpha);

dy_on_alpha = diff(yCenter_on_alpha, l);

dx_on_alpha = sqrt(1 - dy_on_alpha^2);

xCenter_on_alpha = int(dx_on_alpha);

R = [
    1, 0, 0;
    0, cos(alpha), -sin(alpha);
    0, sin(alpha), cos(alpha);
    ];

Center_in_xyz = R * ([xCenter_on_alpha; yCenter_on_alpha; 0]) + 0.1 * [0; -sin(alpha); cos(alpha)];
opposite_edge_in_xyz = Center_in_xyz + (Center_in_xyz - [xCenter_on_alpha; func_length; 0]);

Center_in_xyz = Center_in_xyz';
opposite_edge_in_xyz = opposite_edge_in_xyz';

yCenter_on_alpha = matlabFunction(yCenter_on_alpha);
xCenter_on_alpha = matlabFunction(xCenter_on_alpha);

Center_in_xyz = matlabFunction(Center_in_xyz);
func_length = matlabFunction(func_length);
opposite_edge_in_xyz = matlabFunction(opposite_edge_in_xyz);

alpha = 8/32 * pi;
l = -1:1e-2:1; l = l';

Center_in_xyz = Center_in_xyz(alpha, l);
opposite_edge_in_xyz = opposite_edge_in_xyz(alpha, l);

figure(1)
scatter3(Center_in_xyz(:, 1), Center_in_xyz(:, 2), Center_in_xyz(:, 3))
daspect([1, 1, 1])

xlabel('x')
ylabel('y')
zlabel('z')
% view([1, 0, 0])

hold on
scatter3(xCenter_on_alpha(alpha, l), func_length(l), zeros(size(l)))
scatter3(opposite_edge_in_xyz(:, 1), opposite_edge_in_xyz(:, 2), opposite_edge_in_xyz(:, 3))
hold off

hold on
plot3([opposite_edge_in_xyz(:, 1)'; xCenter_on_alpha(alpha, l)'], ...
    [opposite_edge_in_xyz(:, 2)'; func_length(l)'], ...
    [opposite_edge_in_xyz(:, 3)'; zeros(size(l))'], ...
    'Color', 'black')
hold off

figure(2)
plot(l, xCenter_on_alpha(alpha, l))

curvature_d = fnder(spline(xCenter_on_alpha(alpha, l), func_length(l)));
curvature_dd = fnder(curvature_d);

cauvature = fnval(curvature_dd, xCenter_on_alpha(alpha, l)) ./ (1 + fnval(curvature_d, xCenter_on_alpha(alpha, l)).^2).^(3/2);

figure(3)
plot(xCenter_on_alpha(alpha, l), cauvature)




































