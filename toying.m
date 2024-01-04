%% Generate DSRT File

gpsFileName = "C:\Users\Ufuk\Documents\Projects\SingleReceiverToA\Data\DSRT\Simulated\2023-02-24T11_37_18.100_Digit_424.363MHz_PI_4 DQPSK_18000.gps";
[path, name, ext] = fileparts(gpsFileName);
dsrtFileName = path + "\" + name + ".dsrt";

transmitterX = 47.4599; % latitude
transmitterY = 8.56509; % longitude
offset = -5593.0431;    % in meters

speedOfLight = 0.299792458; % in meters/nanosecs

[gpsData, gpsTime] = readGPS(gpsFileName);

toaValues = calculate_theoretical_ToAs(transmitterX, transmitterY, offset, gpsData); % in meters
toaValues = toaValues + normrnd(0, 50, size(toaValues)); % corrupt ToA values, assume 50 meters of a standard deviation
toaValues = toaValues / speedOfLight; % convert ToA values to time

fid = fopen(dsrtFileName, 'w');
if (fid ~= -1)
    fprintf(fid, "[SingleReceiverTDoA -version=1.1]\n");
    fprintf(fid, "symbol_rate=18000;burst_length=1;tracking=True\n");
    fprintf(fid, "TS=%d\n", gpsTime(1));

    for i = 1:numel(toaValues)
        fprintf(fid, "%d\n", gpsTime(i) + toaValues(i));
    end

    fclose(fid);
else
    warningMessage = sprintf('Cannot open file %s', dsrtFileName);
end




















%% Plot ToA values from C++
fileName = "C:\Users\Ufuk\Desktop\toa_measured_vs_estimated.txt";

toaMeasuredEstimated = readmatrix(fileName);
[~, numCol] = size(toaMeasuredEstimated);

figure
plot(toaMeasuredEstimated(:, 1), 'red'); % measured
hold on

plot(toaMeasuredEstimated(:, 2), 'blue'); % theoretical 1

if (numCol == 3)
    plot(toaMeasuredEstimated(:, 3), 'green'); % theoretical 2
end
