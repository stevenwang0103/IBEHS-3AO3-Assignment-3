%IBEHS 3A03 Assignment 3 
%%
%Part A 
%1
data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
Fs = data.Fs;

% signal = fourier_dt(data,frequency,'full');
% 
% frequencyplot = 0:0.1:100.1;
% 
% plot(frequencyplot,signal)

[Mx_half,phx_half,f_half] = fourier_dt(x,Fs,'half');

plot(f_half,Mx_half)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('Two-sided spectrum')


% [Mx_full,phx_full,f_full] = fourier_dt(x,Fs,'full');
% 
% plot(f_full,Mx_full)
% ylabel('|X(f)|')
% xlabel('F (Hz)')
% title('Two-sided spectrum')

%%
%2
data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
l = 900;
x_portion = x(1:1+l,:);
Fs = data.Fs;

[Mx_half,phx_full,f_half] = fourier_dt(x_portion,Fs,'full');
[Mx_half2,phx_half2,f_half2] = fourier_dt(x,Fs,'full');


plot(f_half,Mx_half)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('One-sided spectrum')
hold on
plot(f_half2,Mx_half2)
hold off 
%%
%3
data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
l = 900;
x_portion = x(1:+l,:);
pad = zeros(l,1);
x_portion_pad = [x_portion' pad'];
Fs = data.Fs;

[Mx_half_pad,phx_half_pad,f_half_pad] = fourier_dt(x_portion_pad,Fs,'full');
[Mx_half,phx_half,f_half] = fourier_dt(x,Fs,'full');


length(Mx_half_pad)
length(Mx_half)

plot(f_half_pad,Mx_half_pad)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('One-sided spectrum')
hold on
plot(f_half,Mx_half)
hold off 
%% 
%determining smallest L
%from 2

data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
Fs = data.Fs;

[Mx_half2,phx_half2,f_half2] = fourier_dt(x,Fs,'full');

avg_origional=sum(Mx_half2)/length(Mx_half2);


%set average threashold and run loop to find smallest l
avg_threashold=avg_origional*1.2;

max_L = 1000;

smallest_L=0;

for l = 1:max_L
    
    %l = 100;
    x_portion = x(1:1+l,:);

    [Mx_half,phx_full,f_half] = fourier_dt(x_portion,Fs,'full');
    avg_trim=sum(Mx_half)/length(Mx_half);
    
    if avg_trim>avg_threashold
       smallest_L=l; 
       smallest_L_Mx_half=Mx_half;
       smallest_L_f_half=f_half;
    end
    
end

smallest_L

plot(smallest_L_f_half,smallest_L_Mx_half)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('One-sided spectrum')
hold on
plot(f_half2,Mx_half2)
hold off 
