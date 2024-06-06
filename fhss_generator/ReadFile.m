function [ fileData ] = ReadFile(fileName, type, dim)
fileData = [];

file = -1;
file = fopen(fileName, 'r');
if file < 0
    return;
end
fseek(file,0,'eof');
lengthBytes = ftell(file);
fseek(file, 0, 'bof');
readedData = fread(file,lengthBytes,type,0);
if(dim == 1)
    fileData = readedData(1:end);
else
    fileData = readedData(1:dim:end) + 1i*readedData(2:dim:end);
end
fclose(file);

end

