clear all; close; clc
% Convert Sparkfun Logomatic V2 binary log data
% binary mnode allows up to 2000 Hz data rate
% J Rogers 17 DEC 2020

% LOGCON.txt:
% MODE = 2
% ASCII = N
% Baud = 4
% Frequency = 2000
% Trigger Character = $
% Text Frame = 100
% AD1.3 = Y
% AD0.3 = N
% AD0.2 = N
% AD0.1 = N
% AD1.2 = N
% AD0.4 = N
% AD1.7 = N
% AD1.6 = N
% Saftey On = N

% Binary data format:
% high byte (8 bits but only lowest two are relevant (0-3)
% low byte  (8 bits, 0-255)
% 36 (frame marker)
% 36 (frame Marker)


fileID = fopen('LOG03.txt');
A = fread(fileID);
fclose(fileID);
numCount = floor(length(A)/4); %divide by 4, the frame size

%%
B = zeros(numCount,1);

for k=1:numCount
    Bhigh = A(4*k-3);
    Blow = A(4*k-2);
    B(k) = Bhigh*256 + Blow;
end
plot(B)
save('myLogomaticBinaryData','B')