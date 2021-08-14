
clear all

syms l alpha real

func_length = 1/8 * l^2;

% r = 100;
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

Center_in_xyz_fcn = matlabFunction(Center_in_xyz);
func_length = matlabFunction(func_length);
opposite_edge_in_xyz_fcn = matlabFunction(opposite_edge_in_xyz);

alpha_all = (16:-4:4)/32 * pi; alpha_all = alpha_all';
l = -1:1e-2:1; l = l';

figure
tiledlayout(2,size(alpha_all, 1))

for alpha_index = 1:size(alpha_all, 1)
    
    alpha = alpha_all(alpha_index);
    
    Center_in_xyz = Center_in_xyz_fcn(alpha, l);
    opposite_edge_in_xyz = opposite_edge_in_xyz_fcn(alpha, l);
    
    nexttile
    scatter3(Center_in_xyz(:, 1), Center_in_xyz(:, 2), Center_in_xyz(:, 3))
    daspect([1, 1, 1])
    
    xlabel('x')
    ylabel('y')
    zlabel('z')
    view([1, 0.1, 0.1])
    
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
    
    curvature_d = fnder(spline(xCenter_on_alpha(alpha, l), func_length(l)));
    curvature_dd = fnder(curvature_d);
    
    curvature = fnval(curvature_dd, xCenter_on_alpha(alpha, l)) ./ (1 + fnval(curvature_d, xCenter_on_alpha(alpha, l)).^2).^(3/2);
    
    nexttile
    plot(xCenter_on_alpha(alpha, l), curvature)
    ax = gca;
    ax.FontSize = 20;
    xlabel('l', 'Interpreter', 'latex')
    ylabel('Curvature')
end






































