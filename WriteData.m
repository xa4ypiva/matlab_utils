function [ status ] = WriteData(fileName, data, precision)
%WRITEDATAIQ Summary of this function goes here
%   Detailed explanation goes here

status = 0;
fId = fopen(fileName, 'w');
if fId == -1
    status = -1;
    exit();
end
fwrite(fId, data, precision);
fclose(fId);

end

