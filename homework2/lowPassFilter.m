function [outputArg1] = lowPassFilter(lapPyr,wl,wh)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明

[length,dims,num] = size(lapPyr);
lpyr = shiftdim(lapPyr,dims-1);

lpyr_fft = fft(lpyr,[],1);

sampleRatio = 30;
lut = 1:num;
lut = (lut' -1)/num*sampleRatio;

lut = repmat(lut,[1,size(lpyr,2),size(lpyr,3)]);

lut = lut > wl & lut <wh;

lpyr_fft(~lut)=0;

lpyr_ifft = ifft(lpyr_fft,[],1);

lpyr = real(lapPyr);

lapPyr = repmat(lpyr,1);

outputArg1 = lapPyr;
end

