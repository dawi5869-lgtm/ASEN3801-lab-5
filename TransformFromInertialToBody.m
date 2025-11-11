function [transformedMatrix] = TransformFromInertialToBody(matrix, eulerAngles)
phi = eulerAngles(1);
theta = eulerAngles(2);
psi = eulerAngles(3);

rotationMatrix = [(cosd(theta)*cosd(psi)) cosd(theta)*sind(psi) (-sind(theta));
    (sind(phi)*sind(theta)*cosd(psi) - cosd(phi)*sind(psi)) (sind(phi)*sind(theta)*sind(psi) - cosd(phi)*cosd(psi)) sind(phi)*cosd(theta);
    (cosd(phi)*sind(theta)*cosd(psi)) + (sind(phi)*sind(psi)) (cosd(phi)*sind(theta)*sind(psi) - sind(phi)*cosd(psi)) cosd(phi)*cosd(theta)];

transformedMatrix = rotationMatrix * matrix;
end