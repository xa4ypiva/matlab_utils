function [ signals ] = LoadHops( fileName )
wordStream = ReadFile(fileName, 'int64', 1);
numFields =  8;

signals = repmat(struct('sessionId',0,'detId',0,'startFreq',0,'stopFreq',0,...
                 'timeStart', 0, 'timeEnd', 0, 'lineNumStart', 0, 'lineNumEnd',0),[fix(length(wordStream))/numFields 1]);
             
for i = 1:length(signals)
    signals(i).sessionId =  wordStream(1+(i-1)*numFields);
    signals(i).detId = wordStream(2+(i-1)*numFields);
    signals(i).startFreq = wordStream(3+(i-1)*numFields);
    signals(i).stopFreq = wordStream(4+(i-1)*numFields);
    signals(i).timeStart = wordStream(5+(i-1)*numFields);
    signals(i).timeEnd = wordStream(6+(i-1)*numFields);
    signals(i).lineNumStart = wordStream(7+(i-1)*numFields);
    signals(i).lineNumEnd = wordStream(8+(i-1)*numFields);
end

end

% TODO: BYTE PARSER

% function [params] = ParseHop(inBytes)
%     params =    struct("sessionId", typecast(inBytes(1:4),'uint64'), ...
%                         "detId", typecast(inBytes(5:8),'uint64'), ...
%                         "startFreq", typecast(inBytes(9:12),'uint32'), ...
%                         "stopFreq", typecast(inBytes(13:16), 'uint32'), ...
%                         "timeStart", typecast(inBytes(17:24), 'uint64'), ...
%                         "timeEnd", typecast(inBytes(25:28), 'uint32'), ...
%                         "lineNumStart", typecast(inBytes(29:32),'uint32'), ...
%                         "lineNumStop", typecast(inBytes(29:32),'uint32'));
% end