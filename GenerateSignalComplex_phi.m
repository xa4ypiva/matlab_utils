function [signal] =  GenerateSignalComplex_phi(data, samples, periods, phiDeg)
    lengthData = length(data);
    lengthPeriod = lengthData * samples;
    lengthSignal = lengthPeriod * periods;
    signal = complex(zeros(1, lengthSignal));
    for pos = 1:lengthData
        signal((pos - 1)*samples + 1: pos*samples) = ...
            ((data(pos) * cos(phiDeg*pi/180)) + 1i * (data(pos) * sin(phiDeg*pi/180)));
    end
    
    if (periods > 1)
        for pos = 1:lengthPeriod
            for j = 1:(periods - 1)
                signal(j*lengthPeriod + pos)=signal(pos);
            end
        end
    end
end