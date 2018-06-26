function [signal] = GenerateSignalReal(data, ampl)
    lengthData = length(data);
    lengthSignal = lengthData;
    signal = zeros(1, lengthSignal);
    for pos = 1:lengthData
        if(data(pos) == 0)
            signal(pos) = ampl;
        end
        if(data(pos) == 1)
            signal(pos) = -ampl;
        end
    end
end

