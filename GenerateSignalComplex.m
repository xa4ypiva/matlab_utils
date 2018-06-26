function [signal] =  GenerateSignalComplex(data, samples, periods)
    lengthData = length(data);
    lengthPeriod = lengthData * samples;
    lengthSignal = lengthPeriod * periods;
    signal = zeros(1, lengthSignal);
    for pos = 1:lengthData
        signal((pos - 1)*samples + 1: pos*samples) = (data(pos) + data(pos) * 1i)/sqrt(2);
    end
    
    if (periods > 1)
        for pos = 1:lengthPeriod
            for j = 1:(periods - 1)
                signal(j*lengthPeriod + pos)=signal(pos);
            end
        end
    end
end