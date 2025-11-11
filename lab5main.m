clc; clear; close all;
ttwistor;

tSpan = 0:10;

%% 2.1
%set input vectors
stateVector = [0; 0; -1609.34; 0; 0; 0; 21; 0; 0; 0; 0; 0];
controls = [0; 0; 0; 0];
wind = [0; 0; 0];

%Simulate the trim dynamics
[t,out] = ode45(@(t,output) AircraftEOM(tSpan, output, controls, wind, aircraft_parameters),tSpan,stateVector);
%Make plots
fig = 1:6;
a = ones(size(t,1));
b = a(1,:);
c = (controls*b);
PlotAircraftSim(t, out, c, fig, '-b')

%% 2.2
%set input vectors
stateVector = [0; 0; -1800; 0; 0.02780*180/pi; 0; 20.99; 0; 0.5837; 0; 0; 0];
controls = [5; 2; -13; 0.3];
wind = [0; 0; 0];

%Simulate the trim dynamics
[t,out] = ode45(@(t,output) AircraftEOM(tSpan, output, controls, wind, aircraft_parameters),tSpan,stateVector);
%Make plots
fig = 7:12;
a = ones(size(t,1));
b = a(1,:);
c = (controls*b);
PlotAircraftSim(t, out, c, fig, '-b')

%% 2.3
%set input vectors
stateVector = [0; 0; -1800; 15; -12; 270; 19; 3; -2; 0.08; -0.2; 0];
controls = [5; 2; -13; 0.3];
wind = [0; 0; 0];

%Simulate the trim dynamics
[t,out] = ode45(@(t,output) AircraftEOM(tSpan, output, controls, wind, aircraft_parameters),tSpan,stateVector);
%Make plots
fig = 13:18;
a = ones(size(t,1));
b = a(1,:);
c = (controls*b);
PlotAircraftSim(t, out, c, fig, '-b')