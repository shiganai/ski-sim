function [value, isterminal, direction] = event_gf(t, q, row_num, col_num, stair_num, ground_force_fcn, external_force_fcn)

point_num = size(q, 1) / 2;
position = reshape(q(1:point_num), row_num, col_num, stair_num, 3);
velocity = reshape(q(point_num + 1:2 * point_num), row_num, col_num, stair_num, 3);

ground_force = ground_force_fcn(t, position);
external_force = external_force_fcn(position, velocity);

ground_force = sum(ground_force(:, :, :, 3), 'all');
external_force = sum(external_force(:, :, :, 3), 'all');

value = ground_force + external_force;
isterminal = 1;
direction = 0;

end

