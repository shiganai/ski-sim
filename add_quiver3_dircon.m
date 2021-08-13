function add_quiver3_dircon(towards,base)

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

