%Name: ASEN-3801 Lab 4 PlotAircaftSim.m
%Date: 10/14/2025
%Authors: Alex Godbout, Christopher Westerlund, Damien Wilson, Maria Cristina Sarno
%Inputs:
%    length 𝑛 vector which holds the time corresponding to the 𝑛𝑛th set of variables, the 12 x 𝑛 array of
%    aircraft states, the 4 by 𝑛𝑛 array of control inputs [𝑍c, 𝐿𝑐, Mc, Nc]T, the 6 x 1 vector of figure numbers to
%    plot over, and the string col which indicates the plotting option used for every plot,
%    eg. col = 'b-'.
%Outputs:
%    The function should plot 6 figures. There should be four figures each with three subplots for the
%    inertial position, Euler angles, inertial velocity in body frame, and angular velocity, respectively.
%    There should be one figure with four subplots for each control input variable. Finally, there should be
%    one figure that shows the three-dimensional path of the aircraft, with positive height upward in the
%    figure. This figure should indicate the start (green) and finish (red) of the path with different colored
%    markers.

function PlotAircraftSim(time, aircraft_state_array, control_input_array, fig, col)

%% Simulate Flight

%Do we need to run ode45 in here or is that done in a seperate function


%% Plot Data
% [x, y, z, φ, θ, ψ, u, v, w, p, q, r] [𝑍𝑍𝑐𝑐, 𝐿𝐿 𝑐𝑐, 𝑀𝑀𝑐𝑐, 𝑁𝑁𝑐𝑐]𝑇𝑇

% Intertial Position
if(fig(1) >=1)
    figure(fig(1));
    hold on;
    hold off;
    sgtitle('Inertial Position against time')
    
    subplot(3,1,1);
    hold on;
    plot(time, aircraft_state_array(:,1), col);
    ylabel('x (m)');
    hold off;
    
    subplot(3,1,2);
    hold on;
    plot(time, aircraft_state_array(:,2), col);
    ylabel('y (m)')
    
    subplot(3,1,3);
    hold on;
    plot(time, aircraft_state_array(:,3), col);
    ylabel('z (m)');
    xlabel('Time (s)');
    hold off
    
end
%Euler Angles
if(fig(2) >=1)
    figure(fig(2)); hold on;
    sgtitle('Aircraft orientation against time')
    subplot(3,1,1); hold on;
    plot(time, rad2deg(aircraft_state_array(:,4)), col);
    ylabel('φ (deg)')
    hold off;

    subplot(3,1,2); hold on;
    plot(time, rad2deg(aircraft_state_array(:,5)), col);
    ylabel('θ (deg)')
    hold off;
    
    subplot(3,1,3); hold on;
    plot(time, rad2deg(aircraft_state_array(:,6)), col);
    ylabel('ψ (deg)');
    xlabel('Time (s)');
    hold off
end
%Inertial Velocity
if(fig(3) >=1)
    figure(fig(3));hold on;
    hold off;
    sgtitle('Inertial velocity against time')
    subplot(3,1,1);hold on;
    plot(time, aircraft_state_array(:,7), col);
    ylabel('u (m/s)')
    hold off;

    subplot(3,1,2); hold on;
    plot(time, aircraft_state_array(:,8), col);
    ylabel('v (m/s)')
    hold off;
    
    subplot(3,1,3); hold on;
    plot(time, aircraft_state_array(:,9), col);
    ylabel('w (m/s)');
    xlabel('Time (s)');
    hold off
end
%Angular Velocity
if(fig(4) >=1)
    figure(fig(4)); hold on;
    hold off;
    sgtitle('Angular velocity against time')
    subplot(3,1,1);hold on;
    plot(time, aircraft_state_array(:,10), col); ylabel('p (rad/s)')
    hold off;
    
    subplot(3,1,2);hold on;
    plot(time, aircraft_state_array(:,11), col); ylabel('q (rad/s)')
    hold off;
    
    subplot(3,1,3);hold on;
    plot(time, aircraft_state_array(:,12), col); ylabel('r (rad/s)'); xlabel('Time (s)');
    hold off
end

%Control Variables
if(fig(5) >=1)
    figure(fig(5)); hold on;
    hold off;
    sgtitle('Control values against time')
    subplot(4,1,1);hold on;
    plot(time, control_input_array(1,:), col);
    ylabel('δe (deg)')
    hold off;

    subplot(4,1,2); hold on;
    plot(time, control_input_array(2,:), col);
    ylabel('δa (deg)')
    hold off;
    
    subplot(4,1,3); hold on;
    plot(time, control_input_array(3,:), col);
    ylabel('δr (deg)')
    hold off;

    subplot(4,1,4); hold on;
    plot(time, control_input_array(4,:) / max(control_input_array(4,:)), col); ylabel('Throttle Percentage'); xlabel('');
    hold off;
end

%3-d Path
if(fig(6) >=1)
    figure(fig(6)); hold on;
    aircraft_state_array(abs(aircraft_state_array)<1e-6)=0;
    view(3);
    plot3(aircraft_state_array(:,1),aircraft_state_array(:,2),-aircraft_state_array(:,3), col); hold on;
    plot3(aircraft_state_array(1,1),aircraft_state_array(1,2),-aircraft_state_array(1,3),'go', 'MarkerFaceColor', 'g'); hold on;
    plot3(aircraft_state_array(end,1),aircraft_state_array(end,2),-aircraft_state_array(end,3),'ro', 'MarkerFaceColor', 'r'); hold on;
    xlabel("North (m)");
    ylabel("East (m)");
    zlabel("Up (m)");
    legend('Path', 'Start point', 'End point')
    grid on;
    %ax = gca; % Get current axes handle
    %ax.DataAspectRatioMode = 'manual';
    %ax.DataAspectRatio = [1 1 1];
    %xlim(lims),ylim(lims),zlim(lims);
    
    hold off;
end
end
