function external_force = external_force_wall(position, limitation, mode, buffer, power)

    
position_y = position(:, :, :, 2);

external_force = zeros(size(position));
external_force_y = external_force(:, :, :, 2);

if isequal(mode, 'smaller')
    external_force_y_after = min(cat(4, external_force_y, -(exp((position_y - limitation) * buffer) - 1) * power), [], 4);
elseif isequal(mode, 'bigger')
    external_force_y_after = max(cat(4, external_force_y, (exp(-(position_y - limitation) * buffer) - 1) * power), [], 4);
else
    error('select mode; smaller or bigger')
end

external_force(:, :, :, 2) = external_force_y_after;


end

