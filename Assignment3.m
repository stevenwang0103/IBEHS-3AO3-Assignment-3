%IBEHS 3A03 Assignment 3 
%%
%Part A 
%1
data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
Fs = data.Fs;

[Mx_full,phx_full,f_full] = fourier_dt(x,Fs,'full');

plot(f_full,Mx_full)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('Full Signal (BFVdu)')

%%
%2
data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
l = 200;
x_portion = x(1:1+l,:);
Fs = data.Fs;

[Mx_portion,phx_portion,f_portion] = fourier_dt(x_portion,Fs,'full');
[Mx_full,phx_full,f_full] = fourier_dt(x,Fs,'full');


plot(f_portion,Mx_portion)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('Signal Portion up to L = 200 vs. Full Signal')
hold on
plot(f_full,Mx_full)
hold off 
legend('Portion of Signal up to L = 200','Full Signal')
%%
%3
data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
l = 200;
x_portion = x(1:1+l,:);
pad = zeros(l,1);
x_portion_pad = [x_portion' pad'];
Fs = data.Fs;

[Mx_pad,phx_pad,f_pad] = fourier_dt(x_portion_pad,Fs,'full');
[Mx_full,phx_full,f_full] = fourier_dt(x,Fs,'full');

plot(f_pad,Mx_pad)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('Signal Portion up to L = 200 with Zero-Padding vs. Full Signal')
hold on
plot(f_full,Mx_full)
hold off 
legend('Portion of Signal up to L = 200 with Zero-Padding','Full Signal')
%% 
%determining smallest L
%from 2

data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
Fs = data.Fs;

[Mx_full,phx_full,f_full] = fourier_dt(x,Fs,'full');

avg_original=sum(Mx_full)/length(Mx_full);


%set average threshold and run loop to find smallest l
avg_threshold=avg_original*1.20;

max_L = 1000;

smallest_L=0;

for l = 1:max_L
    
    %l = 100;
    x_portion = x(1:1+l,:);

    [Mx_portion,phx_portion,f_portion] = fourier_dt(x_portion,Fs,'full');
    avg_trim=sum(Mx_portion)/length(Mx_portion);
    
    if avg_trim>avg_threshold
       smallest_L=l; 
       smallest_L_Mx_full=Mx_portion;
       smallest_L_f_full=f_portion;
    end
    
end

smallest_L

plot(smallest_L_f_full,smallest_L_Mx_full)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('Signal Portion up to L = 855 vs. Full Signal')
hold on
plot(f_full,Mx_full)
hold off 
legend('Portion of Signal up to L = 855','Full Signal')
%%
%after zero pad
data = load('BFVdata_assignment3.mat');
x = data.BFVdu;
%l = smallest_L;
l = 855;
x_portion = x(1:+l,:);
pad = zeros(l,1);
x_portion_pad = [x_portion' pad'];
Fs = data.Fs;

[Mx_full_pad,phx_full_pad,f_full_pad] = fourier_dt(x_portion_pad,Fs,'full');
[Mx_full,phx_full,f_full] = fourier_dt(x,Fs,'full');


length(Mx_full_pad)
length(Mx_full)

plot(f_full_pad,Mx_full_pad)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('Signal Portion up to L = 855 with Zero-Padding vs. Full Signal')
hold on
plot(f_full,Mx_full)
hold off 
legend('Portion of Signal up to L = 855 with Zero-Padding','Full Signal')
%%
%Part B
%1
data = load('EEGdata_assignment3.mat');
EEG1 = data.EEG1;
EEG2 = data.EEG2;
Fs = data.Fs;

% signal = fourier_dt(data,frequency,'full');
% 
% frequencyplot = 0:0.1:100.1;
% 
% plot(frequencyplot,signal)

[Mx_full_EEG1,phx_full_EEG1,f_full_EEG1] = fourier_dt(EEG1,Fs,'full');
[Mx_full_EEG2,phx_full_EEG2,f_full_EEG2] = fourier_dt(EEG2,Fs,'full');

figure(1)
plot(f_full_EEG1,Mx_full_EEG1)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('Two-sided spectrum EEG1')

figure(2)
plot(f_full_EEG2,Mx_full_EEG2)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('Two-sided spectrum EEG2')

%%
%2
data = load('EEGdata_assignment3.mat');
EEG1 = data.EEG1;
EEG2 = data.EEG2;
Fs = data.Fs;
delta=[0,3];
theta=[3,8];
alpha=[8,13];
beta=[13,25];
gamma=[25,100];

[Mx_full_EEG1,phx_full_EEG1,f_full_EEG1] = fourier_dt(EEG1,Fs,'full');
[Mx_full_EEG2,phx_full_EEG2,f_full_EEG2] = fourier_dt(EEG2,Fs,'full');


%EEG1
%delta
indices=find(f_full_EEG1>-3&f_full_EEG1<3);
p_EEG1_delta=sum(Mx_full_EEG1(indices).^2)

%theta
indicesNeg=find(f_full_EEG1>-8&f_full_EEG1<=-3);
indicesPos=find(f_full_EEG1>=3&f_full_EEG1<8);
p_EEG1_theta=sum(Mx_full_EEG1(indicesNeg).^2)+sum(Mx_full_EEG1(indicesPos).^2)

%alpha
indicesNeg=find(f_full_EEG1>-13&f_full_EEG1<=-8);
indicesPos=find(f_full_EEG1>=8&f_full_EEG1<13);
p_EEG1_alpha=sum(Mx_full_EEG1(indicesNeg).^2)+sum(Mx_full_EEG1(indicesPos).^2)

%beta
indicesNeg=find(f_full_EEG1>-25&f_full_EEG1<=-13);
indicesPos=find(f_full_EEG1>=13&f_full_EEG1<25);
p_EEG1_beta=sum(Mx_full_EEG1(indicesNeg).^2)+sum(Mx_full_EEG1(indicesPos).^2)

%gamma
indicesNeg=find(f_full_EEG1>=-100&f_full_EEG1<=-25);
indicesPos=find(f_full_EEG1>=25&f_full_EEG1<=100);
p_EEG1_gamma=sum(Mx_full_EEG1(indicesNeg).^2)+sum(Mx_full_EEG1(indicesPos).^2)


x=categorical({'delta', 'theta', 'alpha',  'beta', 'gamma'});
x=reordercats(x,{'delta', 'theta', 'alpha',  'beta', 'gamma'});
y1=[p_EEG1_delta p_EEG1_theta p_EEG1_alpha p_EEG1_beta p_EEG1_gamma]

figure(1)
bar(x,y1) 
ylabel('Average Band Power')
xlabel('Frequency Range')
title('Band Power at Each Frequency Range EEG1')



%EEG2
%delta
indices=find(f_full_EEG2>-3&f_full_EEG2<3);
p_EEG2_delta=sum(Mx_full_EEG2(indices).^2)

%theta
indicesNeg=find(f_full_EEG2>-8&f_full_EEG2<=-3);
indicesPos=find(f_full_EEG2>=3&f_full_EEG2<8);
p_EEG2_theta=sum(Mx_full_EEG2(indicesNeg).^2)+sum(Mx_full_EEG2(indicesPos).^2)

%alpha
indicesNeg=find(f_full_EEG2>-13&f_full_EEG2<=-8);
indicesPos=find(f_full_EEG2>=8&f_full_EEG2<13);
p_EEG2_alpha=sum(Mx_full_EEG2(indicesNeg).^2)+sum(Mx_full_EEG2(indicesPos).^2)

%beta
indicesNeg=find(f_full_EEG2>-25&f_full_EEG2<=-13);
indicesPos=find(f_full_EEG2>=13&f_full_EEG2<25);
p_EEG2_beta=sum(Mx_full_EEG2(indicesNeg).^2)+sum(Mx_full_EEG2(indicesPos).^2)

%gamma
indicesNeg=find(f_full_EEG2>=-100&f_full_EEG2<=-25);
indicesPos=find(f_full_EEG2>=25&f_full_EEG2<=100);
p_EEG2_gamma=sum(Mx_full_EEG2(indicesNeg).^2)+sum(Mx_full_EEG2(indicesPos).^2)

y2=[p_EEG2_delta p_EEG2_theta p_EEG2_alpha p_EEG2_beta p_EEG2_gamma]
figure(2)
bar(x,y2) 
ylabel('Average Band Power')
xlabel('Frequency Range')
title('Band Power at Each Frequency Range EEG2')

%normalized
bandwidth=[3 5 5 12 75];
y1_normalized=y1./bandwidth;
y2_normalized=y2./bandwidth;

figure(3)
bar(x,y1_normalized) 
ylabel('Average Band Power')
xlabel('Frequency Range')
title('Normalized Band Power at Each Frequency Range EEG1')

figure(4)
bar(x,y2_normalized) 
ylabel('Average Band Power')
xlabel('Frequency Range')
title('Normalized Band Power at Each Frequency Range EEG2')

%%
%EEG
dataEEG = load('EEGdata_assignment3.mat');
EEG1 = dataEEG.EEG1;
EEG2 = dataEEG.EEG2;
FsEEG = dataEEG.Fs;

winlenEEG = 400;  % length of the windowed segments
overlapEEG = 350; % number of samples overlapping for each window position
NFFTEEG = 1000;   % number of points in the FFT (the signal is zero-padded to this length)

figure(1)
subplot(3,1,1)
[s_EGC1,f_EGC1,t_EGC1] = spectrogram(EEG1,winlenEEG,overlapEEG,NFFTEEG,FsEEG);
imagesc(t_EGC1,f_EGC1,abs(s_EGC1)/winlenEEG)
axis xy
ylim([0 10])
title('EEG1')
ylabel('f (Hz)')
cb1 = colorbar;
cb1.Label.String = '|X(f)|';


subplot(3,1,2)
[s_EGC2,f_EGC2,t_EGC2] = spectrogram(EEG2,winlenEEG,overlapEEG,NFFTEEG,FsEEG);
imagesc(t_EGC2,f_EGC2,abs(s_EGC2)/winlenEEG)
axis xy
ylim([0 10])
title('EEG2')
ylabel('f (Hz)')

cb2 = colorbar;
cb2.Label.String = '|X(f)|';

%BFV
dataBFV = load('BFVdata_assignment3.mat');
BFV = dataBFV.BFVdu;
FsBFV = dataBFV.Fs;

winlenBFV = 400;  % length of the windowed segments
overlapBFV = 50; % number of samples overlapping for each window position
NFFTBFV = 2000;   % number of points in the FFT (the signal is zero-padded to this length)

subplot(3,1,3)
[s_EGC1,f_EGC1,t_EGC1] = spectrogram(BFV,winlenBFV,overlapBFV,NFFTBFV,FsBFV);
imagesc(t_EGC1,f_EGC1,abs(s_EGC1)/winlenBFV)
axis xy
ylim([0 2])
title('BFV')
ylabel('f (Hz)')
xlabel('t (s)')
cb1 = colorbar;
cb1.Label.String = '|X(f)|';