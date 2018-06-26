function signal = ReadDataIQ(fileName, iqFormat)
%READDATAIQ Summary of this function goes here
%   Detailed explanation goes here

fileInfo = dir(fileName);
fileId = fopen(fileName);
data = fread(fileId, fileInfo.bytes, iqFormat);
fclose(fileId);

signal = data(1:2:end-1) + 1i * data(2:2:end);

end

