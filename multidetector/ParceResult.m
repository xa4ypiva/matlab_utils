clc
clear 
close all
filenameFound='multidetector/found.bin';
filenamelost='multidetector/lost.bin';
filenamefiniteSignals='multidetector/finiteSignals.bin';

fid1=fopen(filenameFound,'r');
found=zeros(1,7);

i=1;
while(~feof(fid1))
    if(feof(fid1))
        break
    end
found(i,:)=fread(fid1,[1,7],'uint32');
i=i+1;
end
a=1
fclose(fid1);
%%
bandLow=int32(fread())
BandHigh=int32()
snr=uint32()
startTime=int32()
duration=int32()
type=int32()
id=uint32()

