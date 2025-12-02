function xdot = AircraftEOMDoublet(time, aircraft_state, aircraft_surfaces, doublet_size, doublet_time, wind_inertial, aircraft_parameters)

    % for i=1:length(time)
    % 
    %     if (0 < time(i)) && (time(i) <= doublet_time)
    %         aircraft_surfaces(1,i) = deg2rad(aircraft_surfaces(1) + doublet_size);
    %         xdot = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
    % 
    %     elseif (doublet_time < time(i)) && (time(i) <= 2*doublet_time)
    %         aircraft_surfaces(1,i) = deg2rad(aircraft_surfaces(1) - doublet_size);
    %         xdot = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
    % 
    %     else
    %         aircraft_surfaces(1,i) = deg2rad(aircraft_surfaces(1));
    %         xdot = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);
    % 
    %     end
    % end


    if (0 < time) && (time <= doublet_time)
        aircraft_surfaces(1) = deg2rad(aircraft_surfaces(1) + doublet_size);
        xdot = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);

    elseif (doublet_time < time) && (time<= 2*doublet_time)
        aircraft_surfaces(1) = deg2rad(aircraft_surfaces(1) - doublet_size);
        xdot = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);

    else
        aircraft_surfaces(1) = deg2rad(aircraft_surfaces(1));
        xdot = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters);

    end

end