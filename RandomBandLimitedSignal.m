function [ signal, hFilter ] = RandomBandLimitedSignal( fsHz, Tsec, fstop1Hz, fpass1Hz, fpass2Hz, ...
                                                        fstop2Hz, Astop1dB, ApassdB, Astop2dB, distribution)
%RANDOMBANDLIMITEDSIGNAL Summary of this function goes here
%   Detailed explanation goes here

N = fsHz * Tsec;
switch lower(distribution)
    case 'norm'
        data = randn(1, N);
    case 'uniform'
        data = rand(1, N);
    otherwise
        error('unexpected distribution');
        return;
end

hFilterSpec = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', ...
                    fstop1Hz, fpass1Hz, fpass2Hz, fstop2Hz, Astop1dB, ApassdB, Astop2dB, fsHz);
hFilter = design(hFilterSpec, 'equiripple');

signal = filtfilt(hFilter.Numerator, 1, data);
signal = signal / max(abs(signal));

end

