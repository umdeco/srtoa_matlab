function [x, y, epsgCode] = getXY(latitude, longitude)
% Get UTM coordinates from (latitude, longitude) pair

    utmZone = utmzone(latitude, longitude);

    if (numel(utmZone) == 3)
        suffix = utmZone(1:2);
    elseif (numel(utmZone) == 2)
        suffix = "0" + utmZone(1);
    end

    if (latitude >= 0)
        epsgCode = "326" + suffix;
    else
        epsgCode = "327" + suffix;
    end
    epsgCode = str2double(epsgCode);

    proj = projcrs(epsgCode);
    [x, y] = projfwd(proj, latitude, longitude);

end