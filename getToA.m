function [toa] = getToA(transmitterX, transmitterY, receiverX, receiverY , offset)
% Calculate ToA value in meters (distance)

    toa = sqrt((transmitterX - receiverX)^2 + (transmitterY - receiverY)^2) - offset;

end