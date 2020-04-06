function [signal] = Qpsk(Fs, band, timeDuration, timePeriod, usefiltfilt)
oversample = floor(2 * Fs / (3 * band));
numSamples = ceil(Fs * timeDuration);
numPause = ceil(Fs * (timePeriod - timeDuration)); 
numSymbols = floor(numSamples / oversample);
symbols = randi([0 3], 1, numSymbols);
signal = exp(1i*2*pi*symbols/4);
signal = [repelem(signal, oversample), complex(zeros(1, numPause))];

hFilter = fdesign.lowpass('N,Fc', (oversample+4)*12, band/2, Fs);
kaiserCoeff = design(hFilter,'window');

if (nargin > 4)
    if (usefiltfilt)
        signal = filtfilt(kaiserCoeff.Numerator, 1, signal);
    else
        signal = filter(kaiserCoeff.Numerator, 1, signal);
    end
else
    signal = filter(kaiserCoeff.Numerator, 1, signal);
end

end

