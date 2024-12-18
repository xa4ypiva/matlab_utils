clear all;
clc;
% close all;
rng(1);
%rng('shuffle');
set(0,'DefaultFigureWindowStyle','docked');

IS_READ_CPP_DUMP = 0;

% ntr = 4002;
% m = 10;
% resultAFZ = floor((ntr + m - 1) / m) * m
% 
% resultTZ = floor(ntr / m) * m
% 
% resultRoundUp = floor((ntr + (m - 1)) / m) * m
% 
% 
% return
%%
lenFft = 4096;
precision = 'int16';

M = 2;  % fsk alphabet size
gridHz = 25e3;
freqsNum = 16;
band = freqsNum * gridHz;

% packetsNum = 584;

% freqsOffset = randi([-freqsNum/2, freqsNum/2], 1, packetsNum) * gridHz;
precision = 'int64';
freqsOffset_fileID = fopen('/home/evion/projects/BUILD/Hawk/Desktop-Release/infoFreqs','r');
freqsOffset = fread(freqsOffset_fileID,precision);

%fOffset = (-1) * (max(freqsOffset) + min(freqsOffset)) / 2;
fOffset = (-1) * (min(freqsOffset)); 

packetsNum = length(freqsOffset);

precision = 'int32';
infoBits_fileID = fopen('/home/evion/projects/BUILD/Hawk/Desktop-Release/infoBits','r');
infoBitsVec = fread(infoBits_fileID,precision);

infoBits = reshape(infoBitsVec, packetsNum, []);

% fs = 4e4;
fs = 5e6;
tPulse = 9e-3;
% fOffset = 0.1e6 + 12.5e3;
% fOffset = 0;

AMPL = 1e5;

time_info = 8e-3;
time_pause = 1e-3;
time_period = time_info + time_pause;
lenPacket = round(time_period * fs);
iq = zeros(1, packetsNum * lenPacket);



% freqsOffset = zeros(1, packetsNum);
% freqsOffset = ones(1, packetsNum) * (-1000000);
% freqsOffset = [0 0];

win = tukeywin(lenPacket, 0.2).';

% check writing
% freqsOffset_fileID = fopen('/home/artem/Work/Matlab_scripts/fskMod/debugDumps/freqsOffset.bin','r');
% A = fread(freqsOffset_fileID,precision);info(info==0) = -1;
% info(info==1) = 0;
% info(info==-1) = 1;
% fclose(freqsOffset_fileID);

for i = 0 : packetsNum-1
%     info = GenerateInfo(0);
info = infoBits(i + 1, :);
% info(info==0) = -1;
% info(info==1) = 0;
% info(info==-1) = 1;

    % [ signal, data ] = GenerateFhssPacket_updCppRealize(fs, freqOffsetHz, info, timeSignal)    

    %                               freqsOffset(mod(i, freqsNum) + 1), ...
    [fsksignal, packetBits] = GenerateFhssPacket(fs, ...
                                freqsOffset(i + 1), ...
                              info, ...
                              tPulse, ...
                              M);                                                   
    fsksignal = AMPL * fsksignal;   
    iq(i * lenPacket + 1 : (i+1) * lenPacket) = fsksignal;
%     iq = win .* fsksignal;

%     iq(i * lenPacket + 1 : (i+1) * lenPacket) = win .* fsksignal;
%     iq(i * lenPacket + 1 : (i+1) * lenPacket) = fsksignal;

%     iq = fsksignal;
            
%     iq(i * lenPacket + 1 : (i+1) * lenPacket) = win .* ...
%                 GenerateFhssPacket_updCppRealize(fs, freqsOffset(mod(i, freqsNum) + 1), info, tPulse);
end

iq = FrequencyShift(iq, fOffset, fs);
% iq_norm_ToSave = Normalize(iq, 32767);
iq_norm_ToSave = Normalize(iq, 127);


WriteData("iq_16_voice_1_sec", iq_norm_ToSave, 'iq8');

% [~, spec, f] = Spectrum(iq_norm, fs);
[~, spec, f] = Spectrum(iq_norm_ToSave, fs);

%%

% plot(real(iq));
% hold on;
% plot(imag(iq));
% hold on;
%-----------------------------------------------------------
%-----------------------------------------------------------
iq_norm = iq_norm_ToSave;
%-----------------------------------------------------------
%-----------------------------------------------------------

time = 0:1/fs:length(iq_norm)/fs - 1/fs;
timeDiff = time(1 : length(time) - 1);

figure('Name', 'osc re');
plot(time, real(iq_norm));
grid on;

figure('Name', 'osc abs');
plot(time, abs(iq_norm));
grid on;

figure('Name', 'phDiff');
phDiff_matlab = angle(iq_norm(2:end) .* conj(iq_norm(1:end-1)));
plot(timeDiff, phDiff_matlab);
grid on;

figure('Name', 'spec');
plot(f, mag2db(spec));
grid on;

% lenFft = 4096;
figure('Name', 'Spectrogram');
spectrogram(iq_norm, lenFft, lenFft / 2, lenFft, fs, 'centered');



return;
