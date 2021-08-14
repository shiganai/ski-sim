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

dir_config = {
    [1, 0, 0], {};
    [0, 1, 0], {};
    [0, 0, 1], {};
    [1, 1, 0], {};
    [1, -1, 0], {};
    [0, 1, 1], {};
    [0, -1, 1], {};
    [1, 0, 1], {};
    [-1, 0, 1], {};
    [1, 1, 1], {};
    [1, -1, 1], {};
    [-1, 1, 1], {};
    [-1, -1, 1], {};
    };

add_quiver3_dircon(position, dir_config)
























