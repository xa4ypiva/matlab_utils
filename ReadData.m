function data = ReadData(fileName, format, offsetSmpl, length)

if (nargin < 4)
    length = inf;
    if (nargin < 3)
        offsetSmpl = 0;
    end
end

fileId = fopen(fileName);
fseek(fileId, offsetSmpl * sizeof(format), 'bof');
data = fread(fileId, length, format);
fclose(fileId);

end

