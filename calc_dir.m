function [direction, force] = calc_dir_and_force(position, xdir, ydir, zdir, length_init, force, k)

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

if nargin >= 5 && nargout >= 2
    length = vecnorm(direction, 2, 4);
    force_tmp = -k * direction .* (length - length_init);
    force(towards_x, towards_y, towards_z, :) = force(towards_x, towards_y, towards_z, :) + force_tmp;
    force(base_x, base_y, base_z, :) = force(base_x, base_y, base_z, :) - force_tmp;
end

end

