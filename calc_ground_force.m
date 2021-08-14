function ground_force = calc_ground_force(position, height, buffer, power)

position_z = position(:, :, :, 3);

ground_force = zeros(size(position));
ground_force_z = ground_force(:, :, :, 3);

ground_force_z_after = max(cat(4, ground_force_z, (exp(-(position_z - height) * buffer) - 1) * power), [], 4);

ground_force(:, :, :, 3) = ground_force_z_after;

end

