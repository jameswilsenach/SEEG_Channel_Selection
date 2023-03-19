function chans = seegsel(data,options)
% data is an RxMxT data matrix
% options is a struct with the following fields
% fs is the sampling frequency
% freqth is the frequency threshold of interest (Hz)
% energyth is the energy threshold
% winsize is the size of the spectral estimation window (seconds)
if ~isfield(options,'fs')
    options.fs = 1024;
end
if ~isfield(options,'winsize')
    options.winsize = size(data,1);
end
if ~isfield(options,'energyth')
    options.energyth = 0.75;
end
if ~isfield(options,'freqth')
    options.freqth = 32;
end
fs = options.fs;
winsize = options.winsize;
th = options.energyth;
freqth = options.freqth;

win = ones(1,fs*winsize);
[L,P,F,Lc,A] = spod(data,win,ones(1,size(data,2)),0,1./fs);

above_th = find(cumsum(sum(L(F<=freqth,:)))/sum(L(F<=freqth,:),'all')>th);
at_th    = above_th(1);
chans = [];
reddata = data;
otherchans = cell(1,at_th);
for i=1:at_th
    [L,P,F,Lc,A] = spod(reddata,win,ones(1,size(reddata,2)),0,1./1024);
    chanPow = squeeze(sum(abs(P).^2,1));
    chanPow = chanPow*diag(sum(L));
    [~,selchan] = max(chanPow(:,1));
    count = 1;
    while ismember(chanreg(selchan),chanreg(chans))
        chanPow(selchan,1) = 0;
        [~,selchan] = max(chanPow(:,1));
        count = count+1;
        otherchans{i} = [otherchans selchan];
    end
    chans = [chans selchan];
    redP = P;
    redA = A;
    redP(:,:,2:end) = 0;
    redA(:,2:end,2:end)=0;
    X=invspod(redP,redA,win',0);
    reddata = reddata-X;
end