function add_quiver3_dircon(position, xdir, ydir, zdir)

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

towards = position(towards_x, towards_y, towards_z, :);
base = position(base_x, base_y, base_z, :);

target_direction = towards - base;

x_tmp = base(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = base(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = base(:, :, :, 3); z_tmp = z_tmp(:);
u_tmp = target_direction(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = target_direction(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = target_direction(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

end

