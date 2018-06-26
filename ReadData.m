function data = ReadData(fileName, format)
%READDATA Summary of this function goes here
%   Detailed explanation goes here

fileInfo = dir(fileName);
fileId = fopen(fileName);
data = fread(fileId, fileInfo.bytes, format);
fclose(fileId);

end

