function [ signals ] = LoadHop( fileName )
wordStream = ReadFile(fileName, 'int64', 1);
numFields =  5;
signals = repmat(struct('detId',0,'startFreq',0,'stopFreq',0,...
                 'timeStart', 0, 'timeEnd', 0),[fix(length(wordStream))/numFields 1]);
             
for i = 1:length(signals)
    signals(i).detId = wordStream(1+(i-1)*numFields);
    signals(i).startFreq = wordStream(2+(i-1)*numFields);
    signals(i).stopFreq = wordStream(3+(i-1)*numFields);
    signals(i).timeStart = wordStream(4+(i-1)*numFields);
    signals(i).timeEnd = wordStream(5+(i-1)*numFields);
end

end