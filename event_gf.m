function [value, isterminal, direction] = event_gf(t, q, row_num, col_num, stair_num, ground_force_fcn, m, g)

point_num = size(q, 1) / 2;
position = reshape(q(1:point_num), row_num, col_num, stair_num, 3);

ground_force = ground_force_fcn(t, position);

ground_force = sum(ground_force, 'all');

value = ground_force - m * g;
isterminal = 1;
direction = 1;

end

