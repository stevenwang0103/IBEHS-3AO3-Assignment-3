load ECGmV_examples;
Fs

% create time array for the two ECG signals
t = 0:1/Fs:(length(ECG1mV)-1)/Fs;

% find the peaks of the two ECG signals
[xpks1,xlocs1] = findpeaks(ECG1mV,'MinPeakHeight',2);
[xpks2,xlocs2] = findpeaks(ECG2mV,'MinPeakHeight',2);

% extra segments of the two ECG signals within one period
ECG1mV_1p = ECG1mV((xlocs1(5):xlocs1(5)+diff(xlocs1(5:6))-1)-round(diff(xlocs1(5:6))/2));
ECG2mV_1p = ECG2mV((xlocs2(2):xlocs2(2)+round(2/3*diff(xlocs2(2:3)))-1)-round(2/3*diff(xlocs2(2:3))/2));
t1_1p = t((xlocs1(5):xlocs1(5)+diff(xlocs1(5:6))-1)-round(diff(xlocs1(5:6))/2));
t2_1p = t((xlocs2(2):xlocs2(2)+round(2/3*diff(xlocs2(2:3)))-1)-round(2/3*diff(xlocs2(2:3))/2));

% plot the two ECG time-domain signals and the locations of the peaks
figure
subplot(2,1,1)
plot(t,ECG1mV)
hold on
plot(t(xlocs1),xpks1,'r+')
axis([0 35 -1.2 3.2])
ylabel('Amplitude (mV)')
title('ECG1')
subplot(2,1,2)
plot(t,ECG2mV)
hold on
plot(t(xlocs2),xpks2,'r+')
axis([0 35 -1.2 3.2])
ylabel('Amplitude (mV)')
xlabel('t (s)')
title('ECG2')

% Compute the frequency spectra of the two signals
[MECG1,phECG1,fECG1] = fourier_dt(ECG1mV,Fs,'half');
[MECG2,phECG2,fECG2] = fourier_dt(ECG2mV,Fs,'half');

% Compute the frequency spectra of the single-period segments of the two signals
[MECG1_1p,phECG1_1p,fECG1_1p] = fourier_dt(ECG1mV_1p,Fs,'half');
[MECG2_1p,phECG2_1p,fECG2_1p] = fourier_dt(ECG2mV_1p,Fs,'half');

% Create zero-padded versions of the single-period segments and rescale to
% the original signal power (i.e., root-mean-squared value)
ECG1mV_1p_zp = [ECG1mV_1p zeros(1,length(ECG1mV)-length(ECG1mV_1p))]/rms([ECG1mV_1p zeros(1,length(ECG1mV)-length(ECG1mV_1p))])*rms(ECG1mV_1p);
ECG2mV_1p_zp = [ECG2mV_1p zeros(1,length(ECG2mV)-length(ECG2mV_1p))]/rms([ECG2mV_1p zeros(1,length(ECG2mV)-length(ECG2mV_1p))])*rms(ECG2mV_1p);

% Compute the frequency spectra of the zero-padded single-period segments
[MECG1_1p_zp,phECG1_1p_zp,fECG1_1p_zp] = fourier_dt(ECG1mV_1p_zp,Fs,'half');
[MECG2_1p_zp,phECG2_1p_zp,fECG2_1p_zp] = fourier_dt(ECG2mV_1p_zp,Fs,'half');

% plot the magnitude spectra of the two ECG signals
figure
subplot(2,1,1)
plot(fECG1,MECG1)
xlim([0 30])
xticks([0:10 15:5:30])
ylabel('|X(f)| (mV)')
title('ECG1')
subplot(2,1,2)
plot(fECG2,MECG2)
xlim([0 30])
xticks([0:10 15:5:30])
ylabel('|X(f)| (mV)')
title('ECG2')
xlabel('f (Hz)')

% plot the two single-period segments of the ECG signals
figure
subplot(2,1,1)
plot(t1_1p,ECG1mV_1p,'r')
ylabel('Amplitude (mV)')
title('ECG1')
subplot(2,1,2)
plot(t2_1p,ECG2mV_1p,'r')
ylabel('Amplitude (mV)')
xlabel('t (s)')
title('ECG2')

% plot the magnitude spectra of the two single-period segments of the ECG
% signals and compare to the spectra for the full-length signals
figure
subplot(2,1,1)
plot(fECG1,MECG1)
hold on
plot(fECG1_1p,MECG1_1p,'+-')
xlim([0 30])
xticks([0:10 15:5:30])
ylabel('|X(f)| (mV)')
title('ECG1')
legend('Full Signal','Signal Segment')
subplot(2,1,2)
plot(fECG1,MECG2)
hold on
plot(fECG2_1p,MECG2_1p,'+-')
xlim([0 30])
xticks([0:10 15:5:30])
ylabel('|X(f)| (mV)')
title('ECG2')
legend('Full Signal','Signal Segment')
xlabel('f (Hz)')

% plot the magnitude spectra of the zero-padded single-period segments of
% the ECG signals and compare to the spectra for the full-length signals

figure
subplot(2,1,1)
plot(fECG1,MECG1)
hold on
plot(fECG1_1p_zp,MECG1_1p_zp,'-')
xlim([0 30])
xticks([0:10 15:5:30])
ylabel('|X(f)| (mV)')
title('ECG1')
legend('Full Signal','Zero-padded Segment')
subplot(2,1,2)
plot(fECG1,MECG2)
hold on
plot(fECG2_1p_zp,MECG2_1p_zp,'-')
xlim([0 30])
xticks([0:10 15:5:30])
ylabel('|X(f)| (mV)')
title('ECG2')
legend('Full Signal','Zero-padded Segment')
xlabel('f (Hz)')

% plot the spectrograms of the two ECG signals
winlen = 3e3;  % length of the windowed segments
% winlen = 300;  % length of the windowed segments
overlap = 500; % number of samples overlapping for each window position
% overlap = 50; % number of samples overlapping for each window position
NFFT = 10e3;   % number of points in the FFT (the signal is zero-padded to this length)
% NFFT = winlen;   % number of points in the FFT (the signal is zero-padded to this length)

figure
subplot(2,1,1)
[s_EGC1,f_EGC1,t_EGC1] = spectrogram(ECG1mV,winlen,overlap,NFFT,Fs);
imagesc(t_EGC1,f_EGC1,abs(s_EGC1)/winlen)
axis xy
ylim([0 30])
title('ECG1')
ylabel('f (Hz)')
cb1 = colorbar;
cb1.Label.String = '|X(f)| (mV)';
subplot(2,1,2)
[s_EGC2,f_EGC2,t_EGC2] = spectrogram(ECG2mV,winlen,overlap,NFFT,Fs);
imagesc(t_EGC2,f_EGC2,abs(s_EGC2)/winlen)
axis xy
ylim([0 30])
title('ECG2')
ylabel('f (Hz)')
xlabel('t (s)')
cb2 = colorbar;
cb2.Label.String = '|X(f)| (mV)';
