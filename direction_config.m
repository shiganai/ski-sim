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

towards = position(2:end, :, :, :);
base = position(1:end-1, :, :, :);
x_direction = towards - base;
add_quiver3_dircon(towards, base)

towards = position(:, 2:end, :, :);
base = position(:, 1:end-1, :, :);
y_direction = towards - base;
add_quiver3_dircon(towards, base)

towards = position(:, :, 2:end, :);
base = position(:, :, 1:end-1, :);
z_direction = towards - base;
add_quiver3_dircon(towards, base)

%% xy forces

towards = position(2:end, 2:end, :, :);
base = position(1:end-1, 1:end-1, :, :);
xy_direction = towards - base;
add_quiver3_dircon(towards, base)

towards = position(2:end, 1:end-1, :, :);
base = position(1:end-1, 2:end, :, :);
yx_direction = towards - base;
add_quiver3_dircon(towards, base)

%% yz forces

towards = position(:, 2:end, 2:end, :);
base = position(:, 1:end-1, 1:end-1, :);
yz_direction = towards - base;
add_quiver3_dircon(towards, base)


towards = position(:, 1:end-1, 2:end, :);
base = position(:, 2:end, 1:end-1, :);
zy_direction = towards - base;
add_quiver3_dircon(towards, base)


%% zx forces

towards = position(2:end, :, 2:end, :);
base = position(1:end-1, :, 1:end-1, :);
zx_direction = towards - base;
add_quiver3_dircon(towards, base)



towards = position(1:end-1, :, 2:end, :);
base = position(2:end, :, 1:end-1, :);
xz_direction = towards - base;
add_quiver3_dircon(towards, base)


%% xyz forces


towards = position(2:end, 2:end, 2:end, :);
base = position(1:end-1, 1:end-1, 1:end-1, :);
xyz_direction = towards - base;
add_quiver3_dircon(towards, base)


towards = position(2:end, 1:end-1, 2:end, :);
base = position(1:end-1, 2:end, 1:end-1, :);
yxz_direction = towards - base;
add_quiver3_dircon(towards, base)


towards = position(1:end-1, 2:end, 2:end, :);
base = position(2:end, 1:end-1, 1:end-1, :);
add_quiver3_dircon(towards, base)
zxy_direction = towards - base;


towards = position(1:end-1, 1:end-1, 2:end, :);
base = position(2:end, 2:end, 1:end-1, :);
zyx_direction = towards - base;
add_quiver3_dircon(towards, base)
























