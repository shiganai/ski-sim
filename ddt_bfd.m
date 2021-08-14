function dotq = ddt_bfd(t, q, row_num, col_num, stair_num, ...
    spring_force_fcn, dumper_force_fcn, ground_force_fcn, external_force_fcn)

point_num = size(q, 1) / 2;
position = reshape(q(1:point_num), row_num, col_num, stair_num, 3);
velocity = reshape(q(point_num + 1:2 * point_num), row_num, col_num, stair_num, 3);

spring_force = spring_force_fcn(position, velocity);
dumper_force = dumper_force_fcn(position, velocity);
ground_force = ground_force_fcn(position, velocity);
external_force = external_force_fcn(position, velocity);

force = spring_force + dumper_force + ground_force + external_force;

force = reshape(force, point_num, 1);

dotq = [q(point_num + 1:2 * point_num, 1); force];

end

