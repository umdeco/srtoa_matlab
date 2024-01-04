function [gpsData, gpsTime] = readGPS(fileName)
% Read GPS data from supplied file

    fid = fopen(fileName, 'r');
    
    idx = 0;
    gpsData = [];
    gpsTime = [];
    while (1)
        textLine = fgetl(fid);
        idx = idx + 1;
        if (textLine == -1)
            break;
        end
        
        if (idx > 1)
            strSet = split(textLine, ";");          
            gpsTime = [gpsTime; str2num(strSet{1}) * 1000000000];
            latlonPair = split(strSet(2), ",");
            gpsData = [gpsData; [str2double(latlonPair{1}), str2double(latlonPair{2})]];
        end
    end

    fclose(fid);

end