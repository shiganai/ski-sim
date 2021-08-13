col_num = 5;
row_num = 5;
stair_num = 3;

position_init = NaN(row_num, col_num, stair_num, 3);

position_init(:, :, :, 1) = ones(1, row_num, stair_num) .* (1:row_num)';
position_init(:, :, :, 2) = ones(col_num, 1, stair_num) .* (1:col_num);
matrix_tmp(1, 1, 1:stair_num) = 1:stair_num; matrix_tmp = matrix_tmp * 3;
position_init(:, :, :, 3) = ones(row_num, col_num, stair_num) .* matrix_tmp;

position = position_init;
x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);
scatter3(x_tmp, y_tmp, z_tmp)
xlabel('X')
ylabel('Y')
zlabel('Z')
daspect(ones(1,3))

%% straight forces

x_direction = position(2:end, :, :, :) - position(1:end-1, :, :, :);

x_tmp = position(1:end-1, :, :, 1); x_tmp = x_tmp(:);
y_tmp = position(1:end-1, :, :, 2); y_tmp = y_tmp(:);
z_tmp = position(1:end-1, :, :, 3); z_tmp = z_tmp(:);
u_tmp = x_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = x_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = x_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

y_direction = position(:, 2:end, :, :) - position(:, 1:end-1, :, :);

x_tmp = position(:, 1:end-1, :, 1); x_tmp = x_tmp(:);
y_tmp = position(:, 1:end-1, :, 2); y_tmp = y_tmp(:);
z_tmp = position(:, 1:end-1, :, 3); z_tmp = z_tmp(:);
u_tmp = y_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = y_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = y_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

z_direction = position(:, :, 2:end, :) - position(:, :, 1:end-1, :);

x_tmp = position(:, :, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(:, :, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(:, :, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = z_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = z_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = z_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

%% xy forces

xy_direction = position(2:end, 2:end, :, :) - position(1:end-1, 1:end-1, :, :);

x_tmp = position(1:end-1, 1:end-1, :, 1); x_tmp = x_tmp(:);
y_tmp = position(1:end-1, 1:end-1, :, 2); y_tmp = y_tmp(:);
z_tmp = position(1:end-1, 1:end-1, :, 3); z_tmp = z_tmp(:);
u_tmp = xy_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = xy_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = xy_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

yx_direction = position(2:end, 1:end-1, :, :) - position(1:end-1, 2:end, :, :);

x_tmp = position(1:end-1, 2:end, :, 1); x_tmp = x_tmp(:);
y_tmp = position(1:end-1, 2:end, :, 2); y_tmp = y_tmp(:);
z_tmp = position(1:end-1, 2:end, :, 3); z_tmp = z_tmp(:);
u_tmp = yx_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = yx_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = yx_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

%% yz forces

yz_direction = position(:, 2:end, 2:end, :) - position(:, 1:end-1, 1:end-1, :);

x_tmp = position(:, 1:end-1, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(:, 1:end-1, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(:, 1:end-1, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = yz_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = yz_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = yz_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

zy_direction = position(:, 1:end-1, 2:end, :) - position(:, 2:end, 1:end-1, :);

x_tmp = position(:, 2:end, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(:, 2:end, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(:, 2:end, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = zy_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = zy_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = zy_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

%% zx forces

zx_direction = position(2:end, :, 2:end, :) - position(1:end-1, :, 1:end-1, :);

x_tmp = position(1:end-1, :, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(1:end-1, :, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(1:end-1, :, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = zx_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = zx_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = zx_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

xz_direction = position(1:end-1, :, 2:end, :) - position(2:end, :, 1:end-1, :);

x_tmp = position(2:end, :, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(2:end, :, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(2:end, :, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = xz_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = xz_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = xz_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

%% xyz forces

xyz_direction = position(2:end, 2:end, 2:end, :) - position(1:end-1, 1:end-1, 1:end-1, :);

x_tmp = position(1:end-1, 1:end-1, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(1:end-1, 1:end-1, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(1:end-1, 1:end-1, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = xyz_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = xyz_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = xyz_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

yxz_direction = position(2:end, 1:end-1, 2:end, :) - position(1:end-1, 2:end, 1:end-1, :);

x_tmp = position(1:end-1, 2:end, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(1:end-1, 2:end, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(1:end-1, 2:end, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = yxz_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = yxz_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = yxz_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

zxy_direction = position(1:end-1, 2:end, 2:end, :) - position(2:end, 1:end-1, 1:end-1, :);

x_tmp = position(2:end, 1:end-1, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(2:end, 1:end-1, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(2:end, 1:end-1, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = zxy_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = zxy_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = zxy_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

zyx_direction = position(1:end-1, 1:end-1, 2:end, :) - position(2:end, 2:end, 1:end-1, :);

x_tmp = position(2:end, 2:end, 1:end-1, 1); x_tmp = x_tmp(:);
y_tmp = position(2:end, 2:end, 1:end-1, 2); y_tmp = y_tmp(:);
z_tmp = position(2:end, 2:end, 1:end-1, 3); z_tmp = z_tmp(:);
u_tmp = zyx_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = zyx_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = zyx_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off
























