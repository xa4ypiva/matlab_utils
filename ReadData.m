function data = ReadData(fileName, format)

fileId = fopen(fileName);
data = fread(fileId, format);
fclose(fileId);

end

