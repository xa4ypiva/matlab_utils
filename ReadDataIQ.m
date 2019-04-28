function signal = ReadDataIQ(fileName, iqFormat)

fileId = fopen(fileName);
data = fread(fileId, iqFormat);
fclose(fileId);

signal = complex(data(1:2:end-1), data(2:2:end));

end

