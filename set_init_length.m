function dir_config = set_init_length(position_init, dir_config)

for dir_index = 1:size(dir_config, 1)
    dir_array_tmp = dir_config{dir_index, 1};
    dir_tmp = calc_dir(position_init, dir_array_tmp);
    dir_config{dir_index, 2} = vecnorm(dir_tmp, 2, 4);
end

end

