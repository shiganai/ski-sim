function ground_force = ground_force(position, velocity, height, buffer, power, myu)

position_z = position(:, :, :, 3);

ground_force = zeros(size(position));
ground_force_z = ground_force(:, :, :, 3);

ground_force_z_after = max(cat(4, ground_force_z, (exp(-(position_z - height) * buffer) - 1) * power), [], 4);

ground_force(:, :, :, 3) = ground_force_z_after;

ground_friction = zeros(size(position));
ground_friction(:, :, :, 1) = - myu * sign(velocity(:, :, :, 1)) .* ground_force(:, :, :, 3);
ground_friction(:, :, :, 2) = - myu * sign(velocity(:, :, :, 2)) .* ground_force(:, :, :, 3);

ground_force = ground_force + ground_friction;

end

