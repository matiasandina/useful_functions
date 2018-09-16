% This function makes the circles as xy coords
% It's purpose is to display the circles on top of the image
% This could be easily done by using viscircles, however...
% If we want to avoid plotting using viscircles is not the best idea

% circle_coords(xCenter, yCenter, radius, theta_step)
% xCenter and yCenter being the center of the circle
% radius of the circle
% theta_step (try using 0.01) will be the resolution, the smallest the highes res.

% Author: Matias Andina
% https://github.com/matiasandina


function [x, y] = circle_coords(xCenter, yCenter, radius, theta_step)

theta = 0 : theta_step : 2*pi;

x = radius * cos(theta) + xCenter;
y = radius * sin(theta) + yCenter;

end