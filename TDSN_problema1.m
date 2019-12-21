% Demodulación de una señal FSK binaria mediante la STFT

% Preparacion del entorno de trabajo
close all
clear
load incognita

% Espectrograma
signal = incognita;
window = 50;
noverlap = 0;
nfft = window.*3;

colormap('cool');
figure(1);
spectrogram(signal(1:600), window, noverlap, nfft);
xlabel('Frecuency [Hz]');
ylabel('Time [s]');
title('Espectrogram');

% Recogida de valores

S = 0;
F = 0;
T = 0;
fs = 2.*f1;

[S, F, T] = spectrogram(incognita, window, noverlap, nfft, fs);
