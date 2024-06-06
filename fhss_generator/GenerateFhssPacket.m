function [ signal, data ] = GenerateFhssPacket(fs, freqOffsetHz, info, timeSignal, M)
%GENERATEFHSSPACKET Summary of this function goes here
%   Detailed explanation goes here

fPream = 7100;
bitsPerInSymbol = log2(M);
lenSignal = timeSignal * fs;
lenSignalBit = 180;
lenPreamBit = 16;
lenPauseBit = 20;
lenInfoBit = lenSignalBit - lenPreamBit - lenPauseBit;

nOutSamplesPerOneInBit = lenSignal / lenSignalBit;
nOutSamplesPerOneInSample = nOutSamplesPerOneInBit * bitsPerInSymbol;

lenPream = lenPreamBit * nOutSamplesPerOneInBit;
lenInfo = lenInfoBit * nOutSamplesPerOneInBit;
lenPause = lenPauseBit * nOutSamplesPerOneInBit;

if (nargin > 2)
    data = [ones(1, lenPreamBit), info(1 : lenInfoBit)];
else
    data = [ones(1, lenPreamBit), zeros(1, lenInfoBit)];

    data(lenPreamBit + 1 : lenPreamBit + lenInfoBit) = randi([0, 1], 1, lenInfoBit);
end

% bits to samples
symbols = bitsToFSKsymbols(data, M);

%%% y = fskmod(x,M,freq_sep,nSamp,varargin)
% a = fskmod(data, 2, 2 * fPream, bitsPerSymbol, fs);

signal = [zeros(1, lenPause / 2), ...
          fskmod(symbols, M, 2 * fPream, nOutSamplesPerOneInSample, fs), ...
          zeros(1, lenPause / 2)];

% signal = [zeros(1, lenPause / 2), ...
%           fskmodMY(symbols, M, 2 * fPream, nOutSamplesPerOneInSample, fs), ...
%           zeros(1, lenPause / 2)];

% signal = fskmod(samples, M, 2 * fPream, nOutSamplesPerOneInSample, fs);


if (nargin > 1)
    signal = signal ...
        .* exp(1i * 2*pi * freqOffsetHz * (0 : length(signal) - 1) / fs);
end