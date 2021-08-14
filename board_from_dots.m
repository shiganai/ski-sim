
%% initialize

clear all

m = 0.13;
g = 9.8;

row_num = 40;
col_num = 10;
stair_num = 3;
k = 2000;
c = 1;

position_init = NaN(row_num, col_num, stair_num, 3);
velocity_init = zeros(size(position_init));

position_init(:, :, :, 1) = ones(1, col_num, stair_num) .* (1:row_num)' * 2;
position_init(:, :, :, 2) = ones(row_num, 1, stair_num) .* (1:col_num) / 4;
matrix_tmp(1, 1, 1:stair_num) = 1:stair_num; matrix_tmp = matrix_tmp * 0.3;
position_init(:, :, :, 3) = ones(row_num, col_num, stair_num) .* matrix_tmp;

for row_index = 1:row_num
    width = ((row_index/row_num - 1/2) * 2)^2 + 1;
    position_init(row_index, :, :, 2) = ones(1, 1, stair_num) .* linspace(-width, width, col_num)';
end

alpha = 4/16 * pi;
R = [
    1, 0, 0;
    0, cos(alpha), -sin(alpha);
    0, sin(alpha), cos(alpha);
    ];

for target_index = 1:stair_num
    for col_index = 1:col_num
        for row_index = 1:row_num
            vec_tmp = reshape(position_init(row_index, col_index, target_index, :), 3, 1);
            vec_tmp = R * vec_tmp;
            position_init(row_index, col_index, target_index, :) = reshape(vec_tmp, 1, 1, 1, 3);
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

x_tmp = position_init(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = position_init(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = position_init(:, :, :, 3); z_tmp = z_tmp(:);
scatter3(x_tmp, y_tmp, z_tmp)
xlabel('X')
ylabel('Y')
zlabel('Z')
daspect(ones(1,3))

%% at times

time = 0:1e-2:30; time = time';

elevation_speed = 1/10;

q0 = [reshape(position_init, row_num * col_num * stair_num * 3, 1); ...
    reshape(velocity_init, row_num * col_num * stair_num * 3, 1)];

spring_force_fcn = @(position) spring_force(position, dir_config, k);
dumper_force_fcn = @(velocity) - c * velocity;

z_min = min(position_init(:, :, :, 3), [], 'all');
ground_force_fcn = @(t, position) ground_force(position, z_min + t * elevation_speed, 10, 40);
external_force = zeros(size(position_init));

external_force_fcn = @(position, velocity) external_force;
% external_force_fcn = @(position, velocity) external_force_wall(position, 9, 'smaller', 10, 10)...
%     + external_force;

%{/
ode_fcn = @(t, q) ddt_bfd(t, q, row_num, col_num, stair_num, ...
    spring_force_fcn, dumper_force_fcn, ground_force_fcn, external_force_fcn);

event_fcn = @(t, q) event_gf(t, q, row_num, col_num, stair_num, ground_force_fcn, m, g);

ode_option = odeset('Events', event_fcn);

[time, q] = ode45(ode_fcn, time, q0, ode_option);
%}

%{
q = NaN(size(time, 1), size(q0, 1));
q(1,:) = q0;
value = NaN(size(time, 1), 1);

for time_index = 2:size(time, 1)
    time_tmp = time(time_index);
    q_tmp = q(time_index-1, :)';
    dotq = ddt_bfd(time_tmp, q_tmp, row_num, col_num, stair_num, ...
        spring_force_fcn, dumper_force_fcn, ground_force_fcn, external_force_fcn);
    
    [value(time_index), isterminal, direction] = event_gf(time_tmp, q_tmp, row_num, col_num, stair_num, ground_force_fcn, m, g);
    
    q(time_index, :) = q_tmp + dotq * diff(time(1:2));
end

plot(time, value)
%}

position = NaN(row_num, col_num, stair_num, 3, size(time, 1));
x_array = NaN(size(time, 1), row_num * col_num * stair_num + 4);
y_array = NaN(size(x_array));
z_array = NaN(size(x_array));

for q_index = 1:size(q, 1)
    position_tmp = reshape(q(q_index, 1:row_num * col_num * stair_num * 3), ...
        row_num, col_num, stair_num, 3);
    position(:, :, :, :, q_index) = position_tmp;
    
    x_array(q_index, 1:end-4) = reshape(position_tmp(:, :, :, 1), 1, row_num * col_num * stair_num);
    y_array(q_index, 1:end-4) = reshape(position_tmp(:, :, :, 2), 1, row_num * col_num * stair_num);
    z_array(q_index, 1:end-4) = reshape(position_tmp(:, :, :, 3), 1, row_num * col_num * stair_num); 
end

x_array(:, [end-3, end]) = min(x_array, [], 'all', 'omitnan') - 0.1;
x_array(:, [end-2, end-1]) = max(x_array, [], 'all', 'omitnan') + 0.1;

y_array(:, [end-3, end-2]) = min(y_array, [], 'all', 'omitnan') - 0.1;
y_array(:, [end-1, end]) = max(y_array, [], 'all', 'omitnan') + 0.1;

z_array(:, [end-3, end]) = [1, 1] .* (z_min + time/15);
z_array(:, [end-2, end-1]) = [1, 1] .* (z_min + time/15);

%{
anime = SimplestAnime_scatter(time, x_array, y_array, z_array);
anime.axAnime.XLim = [min(x_array, [], 'all'), max(x_array, [], 'all')];
anime.axAnime.YLim = [min(y_array, [], 'all'), max(y_array, [], 'all')];
anime.axAnime.ZLim = [min(z_array, [], 'all'), max(z_array, [], 'all')];
view(anime.axAnime, [0,0.1,1])
daspect(anime.axAnime, [1,1,1])

% target_index_array = find(z_array(1,:) == position_init(1,1,1,3));
target_index_array = 1:row_num * col_num;
for target_index = 1:row_num * col_num
    anime.pAnimes(target_index_array(target_index)).MarkerFaceColor = 'green';
end

target_index_array = 1 + row_num * col_num: 2 *row_num * col_num;
for target_index = 1:row_num * col_num
    anime.pAnimes(target_index_array(target_index)).MarkerFaceColor = 'yellow';
end

anime.pAnimes(end-3).MarkerFaceColor = 'blue';
anime.pAnimes(end-2).MarkerFaceColor = 'blue';
anime.pAnimes(end-1).MarkerFaceColor = 'blue';
anime.pAnimes(end-0).MarkerFaceColor = 'blue';
%}

position_end = position(:, :, :, :, end);
ground_force_end = ground_force_fcn(time(end), position_end);

figure(1)
add_quiver3_force(position_end, ground_force_end)
hold on
surf(x_array(end, end-3:end), y_array(end, end-3:end), ones(4,4) * (z_min + time(end) * elevation_speed))
hold off
view([1,0,0])

time(end)

center_gf = NaN(row_num, 2);
for row_index = 1:row_num
    ground_force_end_row_index = ground_force_end(row_index, :, :, 3);
    
    position_end_row_index = position_end(row_index, :, :, 1);
    center_gf(row_index, 1) = sum(position_end_row_index .* ground_force_end_row_index, 'all', 'omitnan') / sum(ground_force_end_row_index, 'all', 'omitnan');
    
    position_end_row_index = position_end(row_index, :, :, 2);
    center_gf(row_index, 2) = sum(position_end_row_index .* ground_force_end_row_index, 'all', 'omitnan') / sum(ground_force_end_row_index, 'all', 'omitnan');
end


figure(2)
plot(center_gf(:, 2), center_gf(:, 1))
ylim([min(x_array, [], 'all'), max(x_array, [], 'all')]);
xlim([min(y_array, [], 'all'), max(y_array, [], 'all')]);
daspect([1,1,1])









































