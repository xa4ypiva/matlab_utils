function [ status ] = WriteDataIQ(fileName, iq, precision)
%WRITEDATAIQ Summary of this function goes here
%   Detailed explanation goes here

data = zeros(1, 2*length(iq));
data(1:2:end-1) = real(iq);
data(2:2:end) = imag(iq);

status = 0;
fId = fopen(fileName, 'w');
if fId == -1
    status = -1;
    exit();
end
fwrite(fId, data, precision);
fclose(fId);

end

