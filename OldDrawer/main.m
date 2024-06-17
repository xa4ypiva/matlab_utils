% close all;
clear;

%%
clc
% folder = '/home/evion/Downloads/SIGMA/SIGMA_2/';
% [sp, sf, sl] = Drawer(folder, 'amplitudes.bin', 12800, 3125, 'hops.bin', 440000000);

% folder = '/home/evion/projects/BUILD/MultiDetectorTest/build-Emulator-Release/';
% [sp, sf, sl] = Drawer(folder, 'amp_zynq.bin', 12800, 3125, 'hops.bin');

folder = '/home/evion/projects/BUILD/fhss-lib-test/Desktop-Release/';
 [sp, sf, sl] = Drawer(folder, 'parsed_specline1', ...
     6400, 3125, 'sessions/hops_653.bin', 87000000);

%[raw, sp, sf, sl, hops] = DrawerParser(folder, 'raw_60-100-MHz_1_5Sec__ql1', 'int32');

%WriteData("parsed_hops", hops(:),'int32');
%WriteData("parsed_specline", raw(:),'int32');