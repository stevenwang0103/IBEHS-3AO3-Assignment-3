%EEG 
%input time domain 

data = load('EEGdata_assignment4.mat');

EEG = data.EEGa4;
Fs = data.Fs;
time = [0.005:1/Fs:length(EEG)*1/Fs];
EEG = EEG';

figure(1)
plot(time, EEG)
title('Unfiltered EEG Time Domain Signal');
xlabel('Time (s)')
ylabel('Magnitude')
xlim([0 30.05]);

[eeg_mag, eeg_ph, eeg_f] = fourier_dt(EEG, Fs, 'half');

figure(2)
plot(eeg_f, eeg_mag)
title('Unfiltered EEG Magnitude Spectrum');
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure(3)
plot(eeg_f, eeg_ph)
title('Unfiltered EEG Phase Spectrum');
xlabel('Frequency (Hz)')
ylabel('Phase')


%%
%IIR filter
data = load('EEGdata_assignment4.mat');

EEG = data.EEGa4;
Fs = data.Fs;

[eeg_mag_1, eeg_ph_1, eeg_f_1] = fourier_dt(EEG, Fs, 'half');

%zoomed in magnitude spec
figure(1)  
plot(eeg_f_1, eeg_mag_1)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([58 62])
ylim([0 12e-4])

eeg_filtered = filter (EEG_IIR, EEG);
[eeg_filtered_mag, eeg_filtered_ph, eeg_filtered_f] = fourier_dt(eeg_filtered, Fs, 'half');

time = [0.005:1/Fs:length(EEG)*1/Fs];
eeg_filtered = eeg_filtered';

%fltered time domain
figure(2)
plot(time, eeg_filtered)
title('IIR Filtered EEG Time Domain Signal');
xlabel('Time (s)')
ylabel('Magnitude')
xlim([0 30.05]);

%filtered mag and phase spec
%zoomed
figure(3)
plot(eeg_filtered_f, eeg_filtered_mag)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([58 62])
ylim([0 12e-4])

%no zoom
figure(4)
plot(eeg_filtered_f, eeg_filtered_mag)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
%xlim([58 62])
%ylim([0 12e-4])
title('IIR Filtered EEG Magnitude Spectrum');

figure(5)
plot(eeg_filtered_f, eeg_filtered_ph)
xlabel('Frequency (Hz)')
ylabel('Phase')
title('IIR Filtered EEG Phase Spectrum');

%%
%FIR

data = load('EEGdata_assignment4.mat');

EEG = data.EEGa4;
Fs = data.Fs;

[eeg_mag_1, eeg_ph_1, eeg_f_1] = fourier_dt(EEG, Fs, 'half');

%zoomed in magnitude spec
figure(1)  
plot(eeg_f_1, eeg_mag_1)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([58 62])
ylim([0 12e-4])

eeg_filtered = filter (EEG_FIR, EEG);
[eeg_filtered_mag, eeg_filtered_ph, eeg_filtered_f] = fourier_dt(eeg_filtered, Fs, 'half');

time = [0.005:1/Fs:length(EEG)*1/Fs];
eeg_filtered = eeg_filtered';

%fltered time domain
figure(2)
plot(time, eeg_filtered)
title('FIR Filtered EEG Time Domain Signal');
xlabel('Time (s)')
ylabel('Magnitude')
xlim([0 30.05]);

%filtered mag and phase spec
%zoomed
figure(3)
plot(eeg_filtered_f, eeg_filtered_mag)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([58 62])
ylim([0 12e-4])

%no zoom
figure(4)
plot(eeg_filtered_f, eeg_filtered_mag)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
%xlim([58 62])
%ylim([0 12e-4])
title('FIR Filtered EEG Magnitude Spectrum');

figure(5)
plot(eeg_filtered_f, eeg_filtered_ph)
xlabel('Frequency (Hz)')
ylabel('Phase')
title('FIR Filtered EEG Phase Spectrum');

%% 
%VGRF 
%input time domain 

data = load('VGRFdata_assignment4.mat');

VGRF = data.VGRF;
Fs = data.Fs;
time = [0.005:1/Fs:length(VGRF)*1/Fs];
VGRF = VGRF';

figure(1)
plot(time, VGRF)
xlabel('Time (s)')
ylabel('Magnitude')
title('Unfiltered VGRF Time Domain Signal');
% xlim([0 30.05]);

[VGRF_mag, VGRF_ph, VGRF_f] = fourier_dt(VGRF, Fs, 'half');

figure(2)
plot(VGRF_f, VGRF_mag)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Unfiltered VGRF Magnitude Spectrum');

figure(3)
plot(VGRF_f, VGRF_ph)
xlabel('Frequency (Hz)')
ylabel('Phase')
title('Unfiltered VGRF Phase Spectrum');
%%
%IIR 
data = load('VGRFdata_assignment4.mat');

VGRF = data.VGRF;
Fs = data.Fs;

[VGRF_mag_1, VGRF_ph_1, VGRF_f_1] = fourier_dt(VGRF, Fs, 'half');


VGRF_filtered = filter (VGRF_IIR, VGRF);
[VGRF_filtered_mag, VGRF_filtered_ph, VGRF_filtered_f] = fourier_dt(VGRF_filtered, Fs, 'half');

time = [0.005:1/Fs:length(VGRF)*1/Fs];
% VGRF_filtered = VGRF_filtered';

%fltered time domain
figure(1)
plot(time, VGRF_filtered)
xlabel('Time (s)')
ylabel('Magnitude')
title('IIR Filtered VGRF Time Domain Signal');


%filtered mag and phase spec
figure(2)
plot(VGRF_filtered_f, VGRF_filtered_mag)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
ylim([0 140])
title('IIR Filtered VGRF Magnitude Spectrum');


figure(3)
plot(VGRF_filtered_f, VGRF_filtered_ph)
xlabel('Frequency (Hz)')
ylabel('Phase')
title('IIR Filtered VGRF Phase Spectrum');

%%
%FIR 
data = load('VGRFdata_assignment4.mat');

VGRF = data.VGRF;
Fs = data.Fs;

[VGRF_mag_1, VGRF_ph_1, VGRF_f_1] = fourier_dt(VGRF, Fs, 'half');


VGRF_filtered = filter (VGRF_FIR2, VGRF);
[VGRF_filtered_mag, VGRF_filtered_ph, VGRF_filtered_f] = fourier_dt(VGRF_filtered, Fs, 'half');

time = [0.005:1/Fs:length(VGRF)*1/Fs];
% VGRF_filtered = VGRF_filtered';

%fltered time domain
figure(1)
plot(time, VGRF_filtered)
xlabel('Time (s)')
ylabel('Magnitude')
title('FIR Filtered VGRF Time Domain Signal');


%filtered mag and phase spec
figure(2)
plot(VGRF_filtered_f, VGRF_filtered_mag)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
ylim([0 140])
title('FIR Filtered VGRF Magnitude Spectrum');

figure(3)
plot(VGRF_filtered_f, VGRF_filtered_ph)
xlabel('Frequency (Hz)')
ylabel('Phase')
title('FIR Filtered VGRF Phase Spectrum');
