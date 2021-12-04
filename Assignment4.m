%i 
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
xlim([55 65])

y_filtered_mag_spec = filter (Hd, 1, eeg_mag_1);

figure(3)
plot(eeg_f_1, y_filtered_mag_spec)

xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([55 65])
