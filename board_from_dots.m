
%% initialize

clear all

col_num = 5;
row_num = 5;
stair_num = 3;
k = 10;
m = 1;
c = 5;

position_init = NaN(row_num, col_num, stair_num, 3);
velocity_init = zeros(size(position_init));

position_init(:, :, :, 1) = ones(1, col_num, stair_num) .* (1:row_num)';
position_init(:, :, :, 2) = ones(row_num, 1, stair_num) .* (1:col_num);
matrix_tmp(1, 1, 1:stair_num) = 1:stair_num; matrix_tmp = matrix_tmp * 0.5;
position_init(:, :, :, 3) = ones(row_num, col_num, stair_num) .* matrix_tmp;

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

% position = position_init + rand(size(position)) * 0.3;
position = position_init;
position(:, :, :, 3) = position(:, :, :, 3) + ones(1, col_num, stair_num) .* (((1:row_num)'-3)/2).^2;

velocity = velocity_init;

x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);
scatp = scatter3(x_tmp, y_tmp, z_tmp, 2);
xlabel('X')
ylabel('Y')
zlabel('Z')
xlim([0, row_num + 1])
ylim([0, col_num + 1])
zlim([0, stair_num + 1])
daspect(ones(1,3))

time = 0:1e-2:10; time = time';

    
external_force = zeros(size(position));
external_force(1,1,1,3) = 10;

for time_index = 1:size(time, 1)
    
    
    force = zeros(size(position));
    
    %% straight forces
    
    [~, force] = calc_dir_and_force(position, 1, 0, 0, x_length_init, force, k);
    [~, force] = calc_dir_and_force(position, 0, 1, 0, y_length_init, force, k);
    [~, force] = calc_dir_and_force(position, 0, 0, 1, z_length_init, force, k);
    
    %% xy forces
    
    [~, force] = calc_dir_and_force(position, 1, 1, 0, xy_length_init, force, k);
    [~, force] = calc_dir_and_force(position, 1, -1, 0, yx_length_init, force, k);
    
    %% yz forces
    
    [~, force] = calc_dir_and_force(position, 0, 1, 1, yz_length_init, force, k);
    [~, force] = calc_dir_and_force(position, 0, -1, 1, zy_length_init, force, k);
    
    %% zx forces
    
    [~, force] = calc_dir_and_force(position, 1, 0, 1, zx_length_init, force, k);
    [~, force] = calc_dir_and_force(position, -1, 0, 1, xz_length_init, force, k);
    
    %% xyz forces
    
    [~, force] = calc_dir_and_force(position, 1, 1, 1, xyz_length_init, force, k);
    [~, force] = calc_dir_and_force(position, 1, -1, 1, yxz_length_init, force, k);
    [~, force] = calc_dir_and_force(position, -1, 1, 1, zxy_length_init, force, k);
    [~, force] = calc_dir_and_force(position, -1, -1, 1, zyx_length_init, force, k);
    
    %%
    
    force = force - c * velocity + external_force;
    
    position = position + velocity .* diff(time(1:2));
    velocity = velocity + force .* diff(time(1:2));
    
    x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
    y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
    z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);
    scatp.XData = x_tmp;
    scatp.YData = y_tmp;
    scatp.ZData = z_tmp;
    
    if time(time_index) < 3
        drawnow
    end
    
end










































