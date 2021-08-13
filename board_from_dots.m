
%% initialize

col_num = 5;
row_num = 5;
stair_num = 3;
k = 1;
m = 1;

position_init = NaN(row_num, col_num, stair_num, 3);
velocity_init = zeros(size(position_init));

position_init(:, :, :, 1) = ones(1, row_num, stair_num) .* (1:row_num)';
position_init(:, :, :, 2) = ones(col_num, 1, stair_num) .* (1:col_num);
matrix_tmp(1, 1, 1:stair_num) = 1:stair_num; matrix_tmp = matrix_tmp * 1;
position_init(:, :, :, 3) = ones(row_num, col_num, stair_num) .* matrix_tmp;

%% straight forces

x_direction_init = position_init(2:end, :, :, :) - position_init(1:end-1, :, :, :);
x_length_init = vecnorm(x_direction_init, 2, 4);

y_direction_init = position_init(:, 2:end, :, :) - position_init(:, 1:end-1, :, :);
y_length_init = vecnorm(y_direction_init, 2, 4);

z_direction_init = position_init(:, :, 2:end, :) - position_init(:, :, 1:end-1, :);
z_length_init = vecnorm(z_direction_init, 2, 4);

%% xy forces

xy_direction_init = position_init(2:end, 2:end, :, :) - position_init(1:end-1, 1:end-1, :, :);
xy_length_init = vecnorm(xy_direction_init, 2, 4);

yx_direction_init = position_init(2:end, 1:end-1, :, :) - position_init(1:end-1, 2:end, :, :);
yx_length_init = vecnorm(yx_direction_init, 2, 4);

%% yz forces

yz_direction_init = position_init(:, 2:end, 2:end, :) - position_init(:, 1:end-1, 1:end-1, :);
yz_length_init = vecnorm(yz_direction_init, 2, 4);

zy_direction_init = position_init(:, 2:end, 1:end-1, :) - position_init(:, 1:end-1, 2:end, :);
zy_length_init = vecnorm(zy_direction_init, 2, 4);

%% zx forces

zx_direction_init = position_init(2:end, :, 2:end, :) - position_init(1:end-1, :, 1:end-1, :);
zx_length_init = vecnorm(zx_direction_init, 2, 4);

xz_direction_init = position_init(1:end-1, :, 2:end, :) - position_init(2:end, :, 1:end-1, :);
xz_length_init = vecnorm(xz_direction_init, 2, 4);


%% at times

position = position_init;
position(1, 1, 1, 1) = 0;
position(1, 1, 1, 2) = 0;
position(1, 1, 1, 3) = 0;

velocity = velocity_init;

x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);
scatp = scatter3(x_tmp, y_tmp, z_tmp);
xlabel('X')
ylabel('Y')
zlabel('Z')
daspect(ones(1,3))

time = 0:1e-2:1; time = time';

for time_index = 1:size(time, 1)
    
    
    force = zeros(size(position));
    
    %% straight forces
    
    x_direction = position(2:end, :, :, :) - position(1:end-1, :, :, :);
    x_length = vecnorm(x_direction, 2, 4);
    x_force = -k * x_direction .* (x_length - x_length_init);
    force(2:end, :, :, :) = force(2:end, :, :, :) + x_force;
    force(1:end-1, :, :, :) = force(1:end-1, :, :, :) - x_force;
    
    y_direction = position(:, 2:end, :, :) - position(:, 1:end-1, :, :);
    y_length = vecnorm(y_direction, 2, 4);
    y_force = -k * y_direction .* (y_length - y_length_init);
    force(:, 2:end, :, :) = force(:, 2:end, :, :) + y_force;
    force(:, 1:end-1, :, :) = force(:, 1:end-1, :, :) - y_force;
    
    z_direction = position(:, :, 2:end, :) - position(:, :, 1:end-1, :);
    z_length = vecnorm(z_direction, 2, 4);
    z_force = -k * z_direction .* (z_length - z_length_init);
    force(:, :, 2:end, :) = force(:, :, 2:end, :) + z_force;
    force(:, :, 1:end-1, :) = force(:, :, 1:end-1, :) - z_force;
    
    %% xy forces
    
    xy_direction = position(2:end, 2:end, :, :) - position(1:end-1, 1:end-1, :, :);
    xy_length = vecnorm(xy_direction, 2, 4);
    xy_force = -k * xy_direction .* (xy_length - xy_length_init);
    force(2:end, 2:end, :, :) = force(2:end, 2:end, :, :) + xy_force;
    force(1:end-1, 1:end-1, :, :) = force(1:end-1, 1:end-1, :, :) - xy_force;
    
    yx_direction = position(2:end, 1:end-1, :, :) - position(1:end-1, 2:end, :, :);
    yx_length = vecnorm(yx_direction, 2, 4);
    yx_force = -k * yx_direction .* (yx_length - yx_length_init);
    force(2:end, 1:end-1, :, :) = force(2:end, 1:end-1, :, :) + yx_force;
    force(1:end-1, 2:end, :, :) = force(1:end-1, 2:end, :, :) - yx_force;
    
    %% yz forces
    
    yz_direction = position(:, 2:end, 2:end, :) - position(:, 1:end-1, 1:end-1, :);
    yz_length = vecnorm(yz_direction, 2, 4);
    yz_force = -k * yz_direction .* (yz_length - yz_length_init);
    force(:, 2:end, 2:end, :) = force(:, 2:end, 2:end, :) + yz_force;
    force(:, 1:end-1, 1:end-1, :) = force(:, 1:end-1, 1:end-1, :) - yz_force;
    
    zy_direction = position(:, 2:end, 1:end-1, :) - position(:, 1:end-1, 2:end, :);
    zy_length = vecnorm(zy_direction, 2, 4);
    zy_force = -k * zy_direction .* (zy_length - zy_length_init);
    force(:, 2:end, 1:end-1, :) = force(:, 2:end, 1:end-1, :) + zy_force;
    force(:, 1:end-1, 2:end, :) = force(:, 1:end-1, 2:end, :) - zy_force;
    
    %% zx forces
    
    zx_direction = position(2:end, :, 2:end, :) - position(1:end-1, :, 1:end-1, :);
    zx_length = vecnorm(zx_direction, 2, 4);
    zx_force = -k * zx_direction .* (zx_length - zx_length_init);
    force(2:end, :, 2:end, :) = force(2:end, :, 2:end, :) + zx_force;
    force(1:end-1, :, 1:end-1, :) = force(1:end-1, :, 1:end-1, :) - zx_force;
    
    xz_direction = position(1:end-1, :, 2:end, :) - position(2:end, :, 1:end-1, :);
    xz_length = vecnorm(xz_direction, 2, 4);
    xz_force = -k * xz_direction .* (xz_length - xz_length_init);
    force(1:end-1, :, 2:end, :) = force(1:end-1, :, 2:end, :) + xz_force;
    force(2:end, :, 1:end-1, :) = force(2:end, :, 1:end-1, :) - xz_force;
    
    position = position + velocity .* diff(time(1:2));
    velocity = velocity + force .* diff(time(1:2));
    
    x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
    y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
    z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);
    scatp.XData = x_tmp;
    scatp.YData = y_tmp;
    scatp.ZData = z_tmp;
    drawnow
    
end










































