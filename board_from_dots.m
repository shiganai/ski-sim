
col_num = 5;
row_num = 5;
stair_num = 3;

matrix_position_initial = NaN(row_num, col_num, stair_num, 3);

matrix_position_initial(:, :, :, 1) = ones(1, row_num, stair_num) .* (1:row_num)';
matrix_position_initial(:, :, :, 2) = ones(col_num, 1, stair_num) .* (1:col_num);
matrix_tmp(1, 1, 1:stair_num) = 1:stair_num; matrix_tmp = matrix_tmp * 3;
matrix_position_initial(:, :, :, 3) = ones(row_num, col_num, stair_num) .* matrix_tmp;

matrix_position = matrix_position_initial;
x_tmp = matrix_position(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(:, :, :, 3); z_tmp = z_tmp(:);
scatter3(x_tmp, y_tmp, z_tmp)
xlabel('X')
ylabel('Y')
zlabel('Z')
daspect(ones(1,3))

%% straight forces

matrix_x_direction = matrix_position(2:end, :, :, :) - matrix_position(1:end-1, :, :, :);

x_tmp = matrix_position(1:end-1, :, :, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(1:end-1, :, :, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(1:end-1, :, :, 3); z_tmp = z_tmp(:);
u_tmp = matrix_x_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_x_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_x_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

matrix_y_direction = matrix_position(:, 2:end, :, :) - matrix_position(:, 1:end-1, :, :);

x_tmp = matrix_position(:, 1:end-1, :, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(:, 1:end-1, :, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(:, 1:end-1, :, 3); z_tmp = z_tmp(:);
u_tmp = matrix_y_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_y_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_y_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

matrix_z_direction = matrix_position(:, :, 2:end, :) - matrix_position(:, :, 1:end-1, :);

x_tmp = matrix_position(:, :, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(:, :, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(:, :, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = matrix_z_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_z_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_z_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

%% xy forces

matrix_xy_direction = matrix_position(2:end, 2:end, :, :) - matrix_position(1:end-1, 1:end-1, :, :);

x_tmp = matrix_position(1:end-1, 1:end-1, :, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(1:end-1, 1:end-1, :, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(1:end-1, 1:end-1, :, 3); z_tmp = z_tmp(:);
u_tmp = matrix_xy_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_xy_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_xy_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

matrix_yx_direction = matrix_position(2:end, 1:end-1, :, :) - matrix_position(1:end-1, 2:end, :, :);

x_tmp = matrix_position(1:end-1, 2:end, :, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(1:end-1, 2:end, :, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(1:end-1, 2:end, :, 3); z_tmp = z_tmp(:);
u_tmp = matrix_yx_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_yx_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_yx_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

%% yz forces

matrix_yz_direction = matrix_position(:, 2:end, 2:end, :) - matrix_position(:, 1:end-1, 1:end-1, :);

x_tmp = matrix_position(:, 1:end-1, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(:, 1:end-1, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(:, 1:end-1, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = matrix_yz_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_yz_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_yz_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

matrix_zy_direction = matrix_position(:, 2:end, 1:end-1, :) - matrix_position(:, 1:end-1, 2:end, :);

x_tmp = matrix_position(:, 1:end-1, 2:end, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(:, 1:end-1, 2:end, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(:, 1:end-1, 2:end, 3); z_tmp = z_tmp(:);
u_tmp = matrix_zy_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_zy_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_zy_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

%% zx forces

matrix_zx_direction = matrix_position(2:end, :, 2:end, :) - matrix_position(1:end-1, :, 1:end-1, :);

x_tmp = matrix_position(1:end-1, :, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(1:end-1, :, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(1:end-1, :, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = matrix_zx_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_zx_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_zx_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

matrix_xz_direction = matrix_position(1:end-1, :, 2:end, :) - matrix_position(2:end, :, 1:end-1, :);

x_tmp = matrix_position(2:end, :, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = matrix_position(2:end, :, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = matrix_position(2:end, :, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = matrix_xz_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = matrix_xz_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = matrix_xz_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off











































