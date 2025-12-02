function [xdot] = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters)
z = aircraft_state(3); %m
phi = aircraft_state(4); %deg
theta = aircraft_state(5); %deg
psi = aircraft_state(6); %deg
u = aircraft_state(7); %m/s
v = aircraft_state(8); %m/s
w = aircraft_state(9); %m/s
p = aircraft_state(10); %deg/s
q = aircraft_state(11); %deg/s
r = aircraft_state(12); %deg/s

g = aircraft_parameters.g; %m/s^2
m = aircraft_parameters.m; %kg
Ix = aircraft_parameters.Ix; %kg*m^2
Iy = aircraft_parameters.Iy; %kg*m^2
Iz = aircraft_parameters.Iz; %kg*m^2
Ixz = aircraft_parameters.Ixz; %kg*m^2

density = stdatmos(-z);

[forces, moments] = AeroForcesAndMoments(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters);
L = moments(1);
M = moments(2);
N = moments(3);

gamma = Ix*Iz - Ixz^2;
gamma1 = (Ixz*(Ix - Iy + Iz))/gamma;
gamma2 = (Iz*(Iz - Iy) + Ixz^2)/gamma;
gamma3 = Iz/gamma;
gamma4 = Ixz/gamma;
gamma5 = (Iz - Ix)/Iy;
gamma6 = Ixz/Iy;
gamma7 = (Ix*(Ix - Iy) + Ixz^2)/gamma;
gamma8 = Ix/gamma;

velocity = [u; v; w];
angularVelocity = [p; q; r];

%find xDot, yDot, zDot
mat1 = [cosd(theta)*cosd(psi) (sind(phi)*sind(theta)*cosd(psi) - cosd(phi)*sind(psi)) (cosd(phi)*sind(theta)*cosd(psi) + sind(phi)*sind(psi));
    cosd(theta)*sind(psi) (sind(phi)*sind(theta)*sind(psi) + cosd(phi)*cosd(psi)) (cosd(phi)*sind(theta)*sind(psi) - sind(phi)*cosd(psi));
    -sind(theta) sind(phi)*cosd(theta) cosd(phi)*cosd(theta)];

%find phiDot, thetaDot, psiDot
mat2 = [1 sind(phi)*tand(theta) cosd(phi)*tand(theta);
    0 cosd(phi) -sind(phi);
    0 sind(phi)*secd(theta) cosd(phi)*secd(theta)];

%find uDot, vDot, wDot
mat3 = [(r*v - q*w);
    (p*w - r*u);
    (q*u - p*v)];

mat4 = g * [-sind(theta);
    cosd(theta)*sind(phi);
    cosd(theta)*cosd(phi)];

mat5 = (1/m) * forces;

%find pdot, qdot, rdot
mat6 = [(gamma1*p*q - gamma2*q*r);
    (gamma5*p*r - gamma6*(p^2 - r^2));
    (gamma7*p*q - gamma1*q*r)];

mat7 = [(gamma3*L + gamma4*N);
    M/Iy;
    (gamma4*L + gamma8*N)];

xdot(1:3) = mat1*velocity;
xdot(4:6) = mat2*angularVelocity;
xdot(7:9) = mat3 + mat4 + mat5;
xdot(10:12) = mat6 + mat7;
xdot = xdot';
end