function [ status ] = WriteData(fileName, data, precision)

if strcmp(precision, 'iq16') || strcmp(precision, 'iq32')
    if strcmp(precision, 'iq16')
        precision = 'int16';
    end
    if strcmp(precision, 'iq32')
        precision = 'int32';
    end
    data2write = zeros(1, 2 * length(data));
    data2write(1:2:end-1) = real(data);
    data2write(2:2:end) = imag(data);
else
    data2write = data;
end

status = 0;
fId = fopen(fileName, 'w');
if fId == -1
    status = -1;
    exit();
end
fwrite(fId, data2write, precision);
fclose(fId);

end

