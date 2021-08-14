function direction = calc_dir(position, dir_array)

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

end

