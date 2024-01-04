function [latitude, longitude] = getLatLon(x, y, epsgCode)
% Get (latitude, longitude) pair from UTM coordinates 

    proj = projcrs(epsgCode);
    [latitude, longitude] = projinv(proj, x, y);

end