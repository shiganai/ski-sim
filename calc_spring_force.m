function spring_force = calc_spring_force(position, dir_config, k)

spring_force = zeros(size(position));

for dir_config_index = 1:size(dir_config, 1)
    dir_array = dir_config{dir_config_index, 1};
    
    length_init = dir_config{dir_config_index, 2};
    
    xdir = dir_array(1);
    ydir = dir_array(2);
    zdir = dir_array(3);
    
    if xdir > 0
        towards_x = 1 + xdir : size(position, 1);
        base_x = 1 : size(position, 1) - xdir;
    else
        base_x = 1 - xdir : size(position, 1);
        towards_x = 1 : size(position, 1) + xdir;
    end
    
    if ydir > 0
        towards_y = 1 + ydir : size(position, 2);
        base_y = 1 : size(position, 2) - ydir;
    else
        base_y = 1 - ydir : size(position, 2);
        towards_y = 1 : size(position, 2) + ydir;
    end
    
    if zdir > 0
        towards_z = 1 + zdir : size(position, 3);
        base_z = 1 : size(position, 3) - zdir;
    else
        base_z = 1 - zdir : size(position, 3);
        towards_z = 1 : size(position, 3) + zdir;
    end
    
    direction = position(towards_x, towards_y, towards_z, :) ...
        - position(base_x, base_y, base_z, :);
    
    length = vecnorm(direction, 2, 4);
    spring_force_tmp = -k * direction .* (length - length_init);
    spring_force(towards_x, towards_y, towards_z, :) = ...
        spring_force(towards_x, towards_y, towards_z, :) + spring_force_tmp;
    spring_force(base_x, base_y, base_z, :) = ...
        spring_force(base_x, base_y, base_z, :) - spring_force_tmp;
end

end

