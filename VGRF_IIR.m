function Hd = VGRF_IIR
%VGRF_IIR Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.10 and Signal Processing Toolbox 8.6.
% Generated on: 06-Dec-2021 19:39:08

% Chebyshev Type II Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 100;  % Sampling Frequency

Fstop1 = 0.1;         % First Stopband Frequency
Fpass1 = 0.2;         % First Passband Frequency
Fpass2 = 9.9;         % Second Passband Frequency
Fstop2 = 10;          % Second Stopband Frequency
Astop1 = 60;          % First Stopband Attenuation (dB)
Apass  = 0.5;         % Passband Ripple (dB)
Astop2 = 40;          % Second Stopband Attenuation (dB)
match  = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY2 method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
Hd = design(h, 'cheby2', 'MatchExactly', match);

% [EOF]
