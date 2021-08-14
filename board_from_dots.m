
%% initialize

clear all

row_num = 4;
col_num = 20;
stair_num = 3;
k = 200;
m = 1;
c = 30;

position_init = NaN(row_num, col_num, stair_num, 3);
velocity_init = zeros(size(position_init));

position_init(:, :, :, 1) = ones(1, col_num, stair_num) .* (1:row_num)';
position_init(:, :, :, 2) = ones(row_num, 1, stair_num) .* (1:col_num) / 2;
matrix_tmp(1, 1, 1:stair_num) = 1:stair_num; matrix_tmp = matrix_tmp * 1;
position_init(:, :, :, 3) = ones(row_num, col_num, stair_num) .* matrix_tmp;

alpha = 1/6 * pi;
R = [
    1, 0, 0;
    0, cos(alpha), -sin(alpha);
    0, sin(alpha), cos(alpha);
    ];

for stair_index = 1:stair_num
    for col_index = 1:col_num
        for row_index = 1:row_num
            vec_tmp = reshape(position_init(row_index, col_index, stair_index, :), 3, 1);
            vec_tmp = R * vec_tmp;
            position_init(row_index, col_index, stair_index, :) = reshape(vec_tmp, 1, 1, 1, 3);
        end
    end
end

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

dir_config = set_init_length(position_init, dir_config);

%% at times


time = 0:1e-2:100; time = time';

q0 = [reshape(position_init, row_num * col_num * stair_num * 3, 1); ...
    reshape(velocity_init, row_num * col_num * stair_num * 3, 1)];

spring_force_fcn = @(position) calc_spring_force(position, dir_config, k);
ground_force_fcn = @(position) calc_ground_force(position, 1.5, 10, 10);
dumper_force_fcn = @(velocity) - c * velocity;

external_force = ones(size(position_init));
external_force(:, :, :, 1) = 0;
external_force(:, :, :, 3) = -external_force(:, :, :, 3);

external_force_fcn = @(position, velocity) calc_external_force_wall(position, 9, 'smaller', 10, 10)...
    + external_force;

ode_fcn = @(t, q) ddt_bfd(t, q, row_num, col_num, stair_num, ...
    spring_force_fcn, dumper_force_fcn, ground_force_fcn, external_force_fcn);

[time, q] = ode45(ode_fcn, time, q0);

position = NaN(row_num, col_num, stair_num, 3, size(time, 1));
x_array = NaN(size(time, 1), row_num * col_num * stair_num);
y_array = NaN(size(x_array));
z_array = NaN(size(x_array));

for q_index = 1:size(q, 1)
    position_tmp = reshape(q(q_index, 1:row_num * col_num * stair_num * 3), ...
        row_num, col_num, stair_num, 3);
    position(:, :, :, :, q_index) = position_tmp;
    
    x_array(q_index, :) = reshape(position_tmp(:, :, :, 1), 1, row_num * col_num * stair_num);
    y_array(q_index, :) = reshape(position_tmp(:, :, :, 2), 1, row_num * col_num * stair_num);
    z_array(q_index, :) = reshape(position_tmp(:, :, :, 3), 1, row_num * col_num * stair_num); 
end

anime = SimplestAnime_scatter(time, x_array, y_array, z_array);
anime.axAnime.XLim = [min(x_array, [], 'all'), max(x_array, [], 'all')];
anime.axAnime.YLim = [min(y_array, [], 'all'), max(y_array, [], 'all')];
anime.axAnime.ZLim = [min(z_array, [], 'all'), max(z_array, [], 'all')];
view(anime.axAnime, [1,1,1])
daspect(anime.axAnime, [1,1,1])









































