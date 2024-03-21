function [ signals ] = LoadFound( fileName )
wordStream = ReadFile(fileName, 'int32', 1);
numFields =  7;
signals = repmat(struct('id',0,'startFreq',0,'stopFreq',0,'meanSnr',0,...
                 'timeStart', 0, 'duration', 0),[fix(length(wordStream))/numFields 1]);
             
for i = 1:length(signals)
    signals(i).id = wordStream(7+(i-1)*numFields);
    signals(i).startFreq = wordStream(1+(i-1)*numFields);
    signals(i).stopFreq = wordStream(2+(i-1)*numFields);
    signals(i).meanSnr = wordStream(3+(i-1)*numFields);
    signals(i).timeStart = wordStream(4+(i-1)*numFields);
    signals(i).duration = wordStream(5+(i-1)*numFields);
end

end