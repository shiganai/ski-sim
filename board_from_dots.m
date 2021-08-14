
%% initialize

clear all

col_num = 2;
row_num = 4;
stair_num = 3;
k = 200;
m = 1;
c = 30;

position_init = NaN(row_num, col_num, stair_num, 3);
velocity_init = zeros(size(position_init));

position_init(:, :, :, 1) = ones(1, col_num, stair_num) .* (1:row_num)';
position_init(:, :, :, 2) = ones(row_num, 1, stair_num) .* (1:col_num);
matrix_tmp(1, 1, 1:stair_num) = 1:stair_num; matrix_tmp = matrix_tmp * 1;
position_init(:, :, :, 3) = ones(row_num, col_num, stair_num) .* matrix_tmp;

alpha = 0/6 * pi;
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


time = 0:1e-2:3; time = time';

% position = position_init + rand(size(position_init)) * 0.3;
position = position_init;
% position(:, :, :, 3) = position(:, :, :, 3) + ones(1, col_num, stair_num) .* (((1:row_num)'-3)/2).^2;

velocity = velocity_init;

external_force = zeros(size(position));
external_force(:, :, :, 3) = external_force(:, :, :, 3) - 9.8 * m;
% external_force(1,1,2,3) = 10;

x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);
scatp = scatter3(x_tmp, y_tmp, z_tmp, 10);
xlabel('X')
ylabel('Y')
zlabel('Z')
xlim([0, 5])
ylim([-1, 3])
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
    
    spring_force = calc_spring_force(position, dir_config, k);
    ground_force = calc_ground_force(position, 1.2, 10, 10);
    
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









































