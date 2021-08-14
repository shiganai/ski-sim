
%% initialize

clear all

col_num = 2;
row_num = 4;
stair_num = 3;
k = 200;
m = 1;
c = 50;

position_init = NaN(row_num, col_num, stair_num, 3);
velocity_init = zeros(size(position_init));

position_init(:, :, :, 1) = ones(1, col_num, stair_num) .* (1:row_num)';
position_init(:, :, :, 2) = ones(row_num, 1, stair_num) .* (1:col_num);
matrix_tmp(1, 1, 1:stair_num) = 1:stair_num; matrix_tmp = matrix_tmp * 0.5;
position_init(:, :, :, 3) = ones(row_num, col_num, stair_num) .* matrix_tmp;

alpha = 1/6 * pi;
R = [
    1, 0, 0;
    0, cos(alpha), -sin(alpha);
    0, sin(alpha), cos(alpha);
    ];

for row_index = 1:row_num
    for col_index = 1:col_num
        for stair_index = 1:stair_num
            vec_tmp = reshape(position_init(row_index, col_index, stair_index, :), 3, 1);
            vec_tmp = R * vec_tmp;
            position_init(row_index, col_index, stair_index, :) = reshape(vec_tmp, 1, 1, 1, 3);
        end
    end
end

%% straight forces

x_direction_init = calc_dir_and_force(position_init, 1, 0, 0);
x_length_init = vecnorm(x_direction_init, 2, 4);

y_direction_init = calc_dir_and_force(position_init, 0, 1, 0);
y_length_init = vecnorm(y_direction_init, 2, 4);

z_direction_init = calc_dir_and_force(position_init, 0, 0, 1);
z_length_init = vecnorm(z_direction_init, 2, 4);

%% xy forces

xy_direction_init = calc_dir_and_force(position_init, 1, 1, 0);
xy_length_init = vecnorm(xy_direction_init, 2, 4);

yx_direction_init = calc_dir_and_force(position_init, 1, -1, 0);
yx_length_init = vecnorm(yx_direction_init, 2, 4);

%% yz forces

yz_direction_init = calc_dir_and_force(position_init, 0, 1, 1);
yz_length_init = vecnorm(yz_direction_init, 2, 4);

zy_direction_init = calc_dir_and_force(position_init, 0, -1, 1);
zy_length_init = vecnorm(zy_direction_init, 2, 4);

%% zx forces

zx_direction_init = calc_dir_and_force(position_init, 1, 0, 1);
zx_length_init = vecnorm(zx_direction_init, 2, 4);

xz_direction_init = calc_dir_and_force(position_init, -1, 0, 1);
xz_length_init = vecnorm(xz_direction_init, 2, 4);

%% xyz forces

xyz_direction_init = calc_dir_and_force(position_init, 1, 1, 1);
xyz_length_init = vecnorm(xyz_direction_init, 2, 4);

yxz_direction_init = calc_dir_and_force(position_init, 1, -1, 1);
yxz_length_init = vecnorm(yxz_direction_init, 2, 4);

zxy_direction_init = calc_dir_and_force(position_init, -1, 1, 1);
zxy_length_init = vecnorm(zxy_direction_init, 2, 4);

zyx_direction_init = calc_dir_and_force(position_init, -1, -1, 1);
zyx_length_init = vecnorm(zyx_direction_init, 2, 4);

%% at times


time = 0:1e-2:20; time = time';

% position = position_init + rand(size(position_init)) * 0.3;
position = position_init;
% position(:, :, :, 3) = position(:, :, :, 3) + ones(1, col_num, stair_num) .* (((1:row_num)'-3)/2).^2;

velocity = velocity_init;

external_force = zeros(size(position));
external_force(:, :, :, 3) = external_force(:, :, :, 3) - 9.8;
% external_force(1,1,2,3) = 10;

x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);
scatp = scatter3(x_tmp, y_tmp, z_tmp, 10);
xlabel('X')
ylabel('Y')
zlabel('Z')
xlim([0, 5])
ylim([-1, 2])
zlim([0, 4])
daspect(ones(1,3))
view([1,0.1,0])

quiv_force = zeros(size(position));
quiv_force_x_tmp = quiv_force(:, :, :, 1); quiv_force_x_tmp = quiv_force_x_tmp(:);
quiv_force_y_tmp = quiv_force(:, :, :, 2); quiv_force_y_tmp = quiv_force_y_tmp(:);
quiv_force_z_tmp = quiv_force(:, :, :, 3); quiv_force_z_tmp = quiv_force_z_tmp(:);
hold on
quiv = quiver3(x_tmp, y_tmp, z_tmp, quiv_force_x_tmp, quiv_force_y_tmp, quiv_force_z_tmp);
hold off

for time_index = 1:size(time, 1)
    
    
    spring_force = zeros(size(position));
    ground_force = calc_ground_force(position, 1.2, 10, 1);
    
    %% straight forces
    
    [~, spring_force] = calc_dir_and_force(position, 1, 0, 0, x_length_init, spring_force, k);
    [~, spring_force] = calc_dir_and_force(position, 0, 1, 0, y_length_init, spring_force, k);
    [~, spring_force] = calc_dir_and_force(position, 0, 0, 1, z_length_init, spring_force, k);
    
    %% xy forces
    
    [~, spring_force] = calc_dir_and_force(position, 1, 1, 0, xy_length_init, spring_force, k);
    [~, spring_force] = calc_dir_and_force(position, 1, -1, 0, yx_length_init, spring_force, k);
    
    %% yz forces
    
    [~, spring_force] = calc_dir_and_force(position, 0, 1, 1, yz_length_init, spring_force, k);
    [~, spring_force] = calc_dir_and_force(position, 0, -1, 1, zy_length_init, spring_force, k);
    
    %% zx forces
    
    [~, spring_force] = calc_dir_and_force(position, 1, 0, 1, zx_length_init, spring_force, k);
    [~, spring_force] = calc_dir_and_force(position, -1, 0, 1, xz_length_init, spring_force, k);
    
    %% xyz forces
    
    [~, spring_force] = calc_dir_and_force(position, 1, 1, 1, xyz_length_init, spring_force, k);
    [~, spring_force] = calc_dir_and_force(position, 1, -1, 1, yxz_length_init, spring_force, k);
    [~, spring_force] = calc_dir_and_force(position, -1, 1, 1, zxy_length_init, spring_force, k);
    [~, spring_force] = calc_dir_and_force(position, -1, -1, 1, zyx_length_init, spring_force, k);
    
    %%
%     
    force = spring_force - c * velocity + ground_force + external_force;
    
    position = position + velocity .* diff(time(1:2));
    velocity = velocity + force .* diff(time(1:2));
    
    x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
    y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
    z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);
    scatp.XData = x_tmp;
    scatp.YData = y_tmp;
    scatp.ZData = z_tmp;
    
    quiv_force = ground_force;
    quiv_force_x_tmp = quiv_force(:, :, :, 1); quiv_force_x_tmp = quiv_force_x_tmp(:);
    quiv_force_y_tmp = quiv_force(:, :, :, 2); quiv_force_y_tmp = quiv_force_y_tmp(:);
    quiv_force_z_tmp = quiv_force(:, :, :, 3); quiv_force_z_tmp = quiv_force_z_tmp(:);
    quiv.XData = x_tmp;
    quiv.YData = y_tmp;
    quiv.ZData = z_tmp;
    quiv.UData = quiv_force_x_tmp;
    quiv.VData = quiv_force_y_tmp;
    quiv.WData = quiv_force_z_tmp;
    
    
    drawnow
    
end









































