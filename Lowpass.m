%ButterWorth lowpass
clear all
clc
close all

d1 = 0.01; 
d2 = 0.005;

%Passband Ripple 
Rp = -20*log10(1-d1); 
%Stopband attenuation 
Rs = -20*log10(d2);
%cut off frequerncy (radiants per second) 
WP=0.02*pi; 
%stopband frequncy (radiants per second) 
WS=0.1*pi; 

%order of the filter 
%governm by transfer funtions, order = poles of transfer funtions 
% changing order changes the frequency respomce(sharper) 
% x axis to be hertz (normalized fre. can be confusing, Hertzs much better
% to read) 
% look at fft 

%find the order and natural frequency 
%n=lowest filter order 
%WN=cutoff frequency 
[N,WN] = buttord(WP, WS, Rp, Rs); 
%find transfer funtion coefficient 
[b,a] = butter(N,WN); 

[H,O] = freqz(b,a,4000);
figure(1)
subplot(2,1,1)
plot(O/2*pi, mag2db(abs(H)))
xlabel('Frequency (KHz)'), ylabel ('Magnitude(db)')

subplot(2,1,2)
plot(O/2*pi,angle(H)*180/pi)
xlabel('Frequency (KHz)'), ylabel ('Phase Shift??')

figure(2)
load('unknownSignal.mat');
dataOut=filter(b,a,signal);
plot(dataOut)
figure (3) 
plot(signal)