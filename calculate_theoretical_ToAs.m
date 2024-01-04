function [toaValues] = calculate_theoretical_ToAs(transmitterLatitude, transmitterLongitude, offset, gpsData)
% Calculate theoretical ToA values (in meters), for the supplied
% transmitter location and the gps data

[transmitterX, transmitterY, epsgCode] = getXY(transmitterLatitude, transmitterLongitude);

[numRow, numCol] = size(gpsData);
toaValues = zeros(numRow, 1);

for i = 1:numRow

    [receiverX, receiverY, ~] = getXY(gpsData(i, 1), gpsData(i, 2));
    toaValues(i) = getToA(transmitterX, transmitterY, receiverX, receiverY, offset);

end



end