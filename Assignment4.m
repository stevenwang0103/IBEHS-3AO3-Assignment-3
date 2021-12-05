%EEG 
%IIR filter
data = load('EEGdata_assignment4.mat');

EEG = data.EEGa4;
Fs = data.Fs;


[eeg_mag_1, eeg_ph_1, eeg_f_1] = fourier_dt(EEG, Fs, 'half');

figure(1)
plot(eeg_f_1, eeg_mag_1)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure(2)
plot(eeg_f_1, eeg_mag_1)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([58 62])
ylim([0 12e-4])

eeg_filtered = filter (Hd_IIR_fourthorder_chebyshevII, EEG);
[eeg_filtered_mag, eeg_filtered_ph, eeg_filtered_f] = fourier_dt(eeg_filtered, Fs, 'half');

figure(3)
plot(eeg_filtered_f, eeg_filtered_mag)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([58 62])
ylim([0 12e-4])

%%
data = load('EEGdata_assignment4.mat');

EEG = data.EEGa4;
Fs = data.Fs;


[eeg_mag_1, eeg_ph_1, eeg_f_1] = fourier_dt(EEG, Fs, 'half');

figure(1)
plot(eeg_f_1, eeg_mag_1)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure(2)
plot(eeg_f_1, eeg_mag_1)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([58 62])
ylim([0 12e-4])

eeg_filtered = filter (Hd, EEG);
[eeg_filtered_mag, eeg_filtered_ph, eeg_filtered_f] = fourier_dt(eeg_filtered, Fs, 'half');

figure(3)
plot(eeg_filtered_f, eeg_filtered_mag)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([58 62])
ylim([0 12e-4])

%% 
%VGRF
%IIR 
data = load('VGRFdata_assignment4.mat');

VGRF = data.VGRF;
Fs = data.Fs;


[VGRF_mag_1, VGRF_ph_1, VGRF_f_1] = fourier_dt(VGRF, Fs, 'half');

figure(1)
plot(VGRF_f_1, VGRF_mag_1)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure(2)
plot(VGRF_f_1, VGRF_mag_1)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
%xlim([58 62])
%ylim([0 12e-4])

VGRF_filtered = filter (Hd, VGRF);
[VGRF_filtered_mag, VGRF_filtered_ph, VGRF_filtered_f] = fourier_dt(VGRF_filtered, Fs, 'half');

figure(3)
plot(VGRF_filtered_f, VGRF_filtered_mag)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
% xlim([58 62])
ylim([0 1200])

%% 
%VGRF
%FIR 
data = load('VGRFdata_assignment4.mat');

VGRF = data.VGRF;
Fs = data.Fs;


[VGRF_mag_1, VGRF_ph_1, VGRF_f_1] = fourier_dt(VGRF, Fs, 'half');

figure(1)
plot(VGRF_f_1, VGRF_mag_1)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

figure(2)
plot(VGRF_f_1, VGRF_mag_1)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
%xlim([58 62])
%ylim([0 12e-4])

VGRF_filtered = filter (Hd, VGRF);
[VGRF_filtered_mag, VGRF_filtered_ph, VGRF_filtered_f] = fourier_dt(VGRF_filtered, Fs, 'half');

figure(3)
plot(VGRF_filtered_f, VGRF_filtered_mag)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
% xlim([58 62])
ylim([0 1200])