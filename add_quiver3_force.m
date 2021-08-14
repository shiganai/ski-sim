function add_quiver3_force(position, force)


x_tmp = position(:, :, :, 1); x_tmp = x_tmp(:);
y_tmp = position(:, :, :, 2); y_tmp = y_tmp(:);
z_tmp = position(:, :, :, 3); z_tmp = z_tmp(:);

scatter3(x_tmp, y_tmp, z_tmp)
xlabel('X')
ylabel('Y')
zlabel('Z')
daspect(ones(1,3))

u_tmp = force(:, :, :, 1); u_tmp = u_tmp(:);
v_tmp = force(:, :, :, 2); v_tmp = v_tmp(:);
w_tmp = force(:, :, :, 3); w_tmp = w_tmp(:);
hold on
quiver3(x_tmp, y_tmp, z_tmp, u_tmp, v_tmp, w_tmp)
hold off

end

