function data = ReadData(fileName, precision, offsetSmpl, length)

if (nargin < 4)
    length = inf;
    if (nargin < 3)
        offsetSmpl = 0;
    end
end

% if (exist("contains") == 0)
%     contains = @(str, pattern) ~isempty(strfind(str, pattern));    
% end

coeffSample = 1;
isComplex = contains(precision, 'iq') | contains(precision, 'c32');
if isComplex
    coeffSample = 2;
    if strcmp(precision, 'iq16')
        precision = 'int16';
    end
    if strcmp(precision, 'iq32')
        precision = 'int32';
    end
    if strcmp(precision, 'c32')
        precision = 'single';
    end
end

fId = fopen(fileName);
fseek(fId, offsetSmpl * sizeof(precision) * coeffSample, 'bof');
data = fread(fId, length * coeffSample, precision);
fclose(fId);

if isComplex
    data = complex(data(1:2:end-1), data(2:2:end));
end

end

