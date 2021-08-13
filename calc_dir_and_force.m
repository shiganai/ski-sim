function [direction, force] = calc_dir_and_force(position, xdir, ydir, zdir, length_init, force, k)

direction = position(1+xdir:end, 1+ydir:end, 1+zdir:end, :) - position(1:end-xdir, 1:end-ydir, 1:end-zdir, :);

if nargin >= 5 && nargout >= 2
    length = vecnorm(direction, 2, 4);
    force_tmp = -k * direction .* (length - length_init);
    force(1+xdir:end, 1+ydir:end, 1+zdir:end, :) = force(1+xdir:end, 1+ydir:end, 1+zdir:end, :) + force_tmp;
    force(1:end-xdir, 1:end-ydir, 1:end-zdir, :) = force(1:end-xdir, 1:end-ydir, 1:end-zdir, :) - force_tmp;
end

end

