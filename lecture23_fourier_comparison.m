syms t w W % declare symbolic variables

% set up signal parameters and create C-T signal
A0 = 1;     % signal amplitude
w0 = pi;      % signal frequency (rad/s)
dur = 10;      % sinusoidal burst duration; must be integer multiple of 2

xt = A0*cos(w0*t)*heaviside(dur/2-t)*heaviside(t+dur/2); % C-T sinusoidal burst signal

% set up sampling parameters and create D-T signal
Ts = 0.4;     % set sampling period in seconds
Fs = 1/Ts;    % sampling frequency in Hz
ws = 2*pi*Fs; % sampling frequency in rad/s
W0 = w0*Ts;   % signal frequency in radians/sample
n = -dur/2/Ts:dur/2/Ts; % sample indices for D-T signal
N = length(n);  % length of D-T signal

xn = A0*cos(w0*n*Ts).*unitstep(dur/2-n*Ts).*unitstep(n*Ts+dur/2); % D-T sinusoidal burst signal

% Compute Fourier transforms
Xw = fourier(xt,t,w); % compute CTFT
XW = sum(xn.*exp(-1j*W*n)); % compute DTFT
Xk = fft(xn); % compute DFT
k = 0:(N-1); % frequency indices for DFT

% zero-pad D-T signal and compute DFT
zp_length = N; % amount of zero-padding
xn_zp = [xn zeros(1,zp_length)]; % zero-pad the signal
N_zp = length(xn_zp); % length of zero-padded signal
Xk_zp = fft(xn_zp); % compute DFT of zero-padded signal
k_zp = 0:(N_zp-1); % frequency indices for DFT of zero-padded signal

%% Plot x(t) and x[n]
figure
subplot(2,1,1)
fplot(xt,[-dur dur]) % plot x(t)
ylim([-1.2*A0 1.2*A0])
xlabel('t (s)')
ylabel('x(t)')
title('C-T signal')
subplot(2,1,2)
stem(n,xn) % plot x[n]
xlabel('n')
ylabel('x[n]')
title(['D-T signal; T_s = ' num2str(Ts) ' s']) % indicate sampling period in subplot title
xlim([-dur/Ts dur/Ts])
ylim([-1.2*A0 1.2*A0])

%% Plot CTFT, DTFT and DFT
figure
subplot(3,1,1)
fp = fplot(abs(Xw),[-1.5*ws 1.5*ws]); % plot amplitude spectrum of x(t)
fp.MeshDensity = 100; % increase the number of points at which the amplitude spectrum is evaluated
hold on
plot(-w0*ones(1,2),[0 1.2*limit(abs(Xw),w,-w0)],'k--') % indicate the -ve signal frequency
plot(w0*ones(1,2),[0 1.2*limit(abs(Xw),w,w0)],'k--')   % indicate the =ve signal frequency
text(w0+0.2,1.07*limit(abs(Xw),w,w0),['\omega_0 = ' num2str(w0,3) ' rad/s'])
plot(-ws*ones(1,2),[0 1.2*limit(abs(Xw),w,-w0)],'k--') % indicate the -ve sampling frequency
plot(ws*ones(1,2),[0 1.2*limit(abs(Xw),w,w0)],'k--')   % indicate the +ve sampling frequency
text(ws+0.2,1.07*limit(abs(Xw),w,w0),['\omega_s = ' num2str(ws,3) ' rad/s'])
xlabel('\omega (rad/s)')
ylabel('|X(\omega)|')
title('CTFT')
subplot(3,1,2)
fplot(abs(XW),[-3*pi 3*pi]) % plot amplitude spectrum of x[n] from DTFT
hold on
plot(-W0*ones(1,2),[0 1.2*limit(abs(XW),W,-W0)],'k--') % indicate the -ve signal frequency
plot(W0*ones(1,2),[0 1.2*limit(abs(XW),W,W0)],'k--')   % indicate the +ve signal frequency
text(W0+0.08,1.07*limit(abs(XW),W,W0),['\Omega_0 = ' num2str(W0,3) ' rad/sample'])
plot(-2*pi*ones(1,2),[0 1.2*limit(abs(XW),W,-W0)],'k--') % indicate the -ve sampling frequency
plot(2*pi*ones(1,2),[0 1.2*limit(abs(XW),W,W0)],'k--')   % indicate the +ve sampling frequency
text(2*pi+0.08,1.07*limit(abs(XW),W,W0),'\Omega = 2\pi rad/sample')
xlabel('\Omega (rad/sample)')
ylabel('|X(\Omega)|')
title('DTFT')
subplot(3,1,3)
stem(k,abs(Xk)) % plot amplitude spectrum of x[n] from DFT
hold on
plot(W0/(2*pi)*N*ones(1,2),[0 1.2*max(abs(Xk))],'k--')   % indicate the +ve signal frequency
text(W0/(2*pi)*N+0.5,1.07*max(abs(Xk)),'\Omega_0/(2\pi)\cdotN')
plot(N*ones(1,2),[0 1.2*max(abs(Xk))],'k--')             % indicate the +ve sampling frequency
text(N+0.3,1.07*max(abs(Xk)),['k = N = ' num2str(N) ' samples'])
xlabel('k')
ylabel('|X_k|')
title('DFT')
xlim([-1.5*(max(k)+1) 1.5*(max(k)+1)])
ylim([0 1.2*max(abs(Xk))])

%% Plot DTFT, DFT and zero-padded DFT
figure
subplot(3,1,1)
fplot(abs(XW),[-3*pi 3*pi]) % plot amplitude spectrum of x[n] from DTFT
hold on
plot(-W0*ones(1,2),[0 1.2*limit(abs(XW),W,-W0)],'k--') % indicate the -ve signal frequency
plot(W0*ones(1,2),[0 1.2*limit(abs(XW),W,W0)],'k--')   % indicate the +ve signal frequency
text(W0+0.08,1.07*limit(abs(XW),W,W0),['\Omega_0 = ' num2str(W0,3) ' rad/sample'])
plot(-2*pi*ones(1,2),[0 1.2*limit(abs(XW),W,-W0)],'k--') % indicate the -ve sampling frequency
plot(2*pi*ones(1,2),[0 1.2*limit(abs(XW),W,W0)],'k--')   % indicate the +ve sampling frequency
text(2*pi+0.08,1.07*limit(abs(XW),W,W0),'\Omega = 2\pi rad/sample')
xlabel('\Omega (rad/sample)')
ylabel('|X(\Omega)|')
title('DTFT')
subplot(3,1,2)
stem(k,abs(Xk)) % plot amplitude spectrum of x[n] from DFT
hold on
plot(W0/(2*pi)*N*ones(1,2),[0 1.2*max(abs(Xk))],'k--')   % indicate the +ve signal frequency
text(W0/(2*pi)*N+0.5,1.07*max(abs(Xk)),'\Omega_0/(2\pi)\cdotN')
plot(N*ones(1,2),[0 1.2*max(abs(Xk))],'k--')             % indicate the +ve sampling frequency
text(N+0.3,1.07*max(abs(Xk)),['k = N = ' num2str(N) ' samples'])
xlabel('k')
ylabel('|X_k|')
title('DFT')
xlim([-1.5*(max(k)+1) 1.5*(max(k)+1)])
ylim([0 1.2*max(abs(Xk))])
subplot(3,1,3)
stem(k_zp,abs(Xk_zp)) % plot amplitude spectrum of zero-padded x[n] from DFT
hold on
plot(W0/(2*pi)*N_zp*ones(1,2),[0 1.2*max(abs(Xk))],'k--') % indicate the +ve signal frequency
text(W0/(2*pi)*N_zp+0.3,1.07*max(abs(Xk)),'\Omega_0/(2\pi)\cdotN_{zp}')
plot(N_zp*ones(1,2),[0 1.2*max(abs(Xk_zp))],'k--')        % indicate the +ve sampling frequency
text(N_zp+0.6,1.07*max(abs(Xk_zp)),['k = N_{zp} = ' num2str(N_zp) ' samples'])
xlabel('k')
ylabel('|X_{zp,k}|')
title('DFT of zero-padded x[n]')
xlim([-1.5*(max(k_zp)+1) 1.5*(max(k_zp)+1)])
ylim([0 1.2*max(abs(Xk_zp))])



