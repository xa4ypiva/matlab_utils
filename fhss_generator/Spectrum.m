function [spectrum, spectrumAbs, frequencies] = Spectrum(signal, fs, dimension)

frequencies = [];

if (nargin < 3 || isempty(dimension))
    if (isrow(signal) || iscolumn(signal))
        [~, szMaxInd] = max(size(signal));
        dimension = szMaxInd;
    elseif (ismatrix(signal))
        dimension = 1;
    end
end

N = size(signal, dimension);

if (nargin > 1 && ~isempty(fs))
    frequencies = (-N/2 : (N-1)/2) * fs / N;
end

spectrum = fftshift(fft(signal, N, dimension), dimension);
spectrumAbs = abs(spectrum);

end

