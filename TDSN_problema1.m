% Demodulación de una señal FSK binaria mediante la STFT

% Preparacion del entorno de trabajo
close all
clear
load incognita

% Espectrograma
signal_recortada = incognita(1:600);
window = 40;
noverlap = 0;
nfft = 80;

colormap('default');
spectrogram(signal_recortada, window, noverlap, nfft);

% Recogida de valores

S = 0;
F = 0;
T = 0;
fs = 2.*f1;

[S, F, T] = spectrogram(incognita, window, noverlap, nfft, fs);
