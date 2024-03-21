% close all;
clear;

%%
clc
folder = '/home/evion/Downloads/ZYNQ/';

%[sp, sf, sl] = Drawer(folder, 'specline_18026', 'int32');
[sp, sf, sl] = DrawerParser(folder, 'specline_18026', 'int32');
