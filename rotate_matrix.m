% This function takes a matrix and rotates with an angle
% Input arguments
% matrix: matrix to rotate, shoud have x and y coordinates as column vectors
% angle: angle to rotate in degrees
% x_center and y_center


function out = rotate_matrix(matrix,angle,x_center,y_center)
% define angle in degrees
% choose a point which will be the center of rotation
% create a matrix which will be used later in calculations
center = transpose([repmat([x_center],1,size(matrix,1));repmat([y_center],1,size(matrix,1))]);

% define theta angle
theta = angle*pi/180;       % from degrees to pi radians is angle times 3,1416 divided by 180 (yes! pi=3,1416)
% create rotation matrix for rotation of theta degrees
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
% do the rotation...
s = matrix - center;     % shift points in the plane so that the center of rotation is at the origin
so = R*transpose(s);           % apply the rotation about the origin; transpose needed for multiplication
out = transpose(so) + center;   % shift again so the origin goes back to the desired center of rotation
% this can be done in one line as:
% vo = R*(v - center) + center
% make a plot
plot(matrix(:,1), matrix(:,2), 'k.', out(:,1), out(:,2), 'r.', x_center, y_center, 'bo');
axis equal

return;