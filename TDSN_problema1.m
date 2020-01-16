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

colormap('jet');
figure(1);
spectrogram(signal(1:600), window, noverlap, nfft);
xlabel('Frecuency [Hz]');
ylabel('Time [s]');
title('Espectrogram');

% Recogida de valores

S = 0; F = 0; T = 0;

[S, F, T] = spectrogram(incognita, window, noverlap, nfft, fs);

% Obtenemos la ristra de bits

bits = zeros(1, 9600);

for i= 1:9600
    if(max(abs(S(:,i))) < 13.272) % 13.2732 = '0'y 13.2711 = '1'
        bits(i) = 1;
    end
end

% Sacamos el mensaje decodificado por consola
binToTxt(bits)


% DECODIFICACION DE LA SEÑAL DTMF

% Preparamos el entorno
clear
load telef1.mat

% Definicion de constantes
f1_freqs = [704, 792, 872, 956];
f2_freqs = [1224, 1386, 1512];
window_DTMF = 400;
noverlap = 0;
nffs = window_DTMF.*3;

% Representación del espectrograma
figure(2);
spectrogram(telef, window_DTMF, noverlap, nffs, fs);

% Calculo de la STFT

S = 0; F = 0; T = 0;

[S, F, T] = spectrogram(telef, window_DTMF, noverlap, nffs, fs);

% Decodificacion de la señal DTMF

S_set = unique(max(abs(S))); 

% Mapa relacional 
keySet = {f1_freqs(1) + f2_freqs(1),...
    f1_freqs(1) + f2_freqs(2),...
    f1_freqs(1) + f2_freqs(3),...
    f1_freqs(2) + f2_freqs(1),...
    f1_freqs(2) + f2_freqs(2),...
    f1_freqs(2) + f2_freqs(3),...
    f1_freqs(3) + f2_freqs(1),...
    f1_freqs(3) + f2_freqs(2),...
    f1_freqs(3) + f2_freqs(3),...
    f1_freqs(4) + f2_freqs(1),...
    f1_freqs(4) + f2_freqs(2),...
    f1_freqs(4) + f2_freqs(3)}

valueSet = {'1', '2', '3', '4', '5',...
    '6', '7','8','9','#','0','*'}

dict = containers.Map(keySet, valueSet);

% Bucle de muestreo
sampled_S = zeros(601,1);
real_S = abs(S);
n = 2
while n <= 42
    sampled_S = [sampled_S real_S(:,n)];
    n = n+5;
end

% Quito el primer vector, residuo de la inizializacion
sampled_S = sampled_S(:, 2:end);


S_posible_repeated = [];
f1s = [];
f2s = [];
for i = 1:9
    sorted = sort(sampled_S(:,i));
    disp(sorted(end-1:end));
    s1 = sorted(end);
    s2 = sorted(end-1);
    s1_s2 = [s1 s2];
    f1s = [f1s s1];
    f2s = [f2s s2];
    
    S_posible_repeated = [S_posible_repeated s1_s2];
end

set_S_posible = unique(S_posible_repeated);


auxf1= [];
auxf2=[];
for j = 1:9
    f11j = does_freq_exists(sampled_S(107,j));
    f12j = does_freq_exists(sampled_S(119,j));
    f13j = does_freq_exists(sampled_S(132,j));
    f14j = does_freq_exists(sampled_S(144,j));
    
    f21j = does_freq_exists(sampled_S(185,j));
    f22j = does_freq_exists(sampled_S(206,j));
    f23j = does_freq_exists(sampled_S(228,j));
    
    auxf1 = [auxf1 ; [f11j f12j f13j f14j]];
    auxf2 = [auxf2 ; [f21j f22j f23j]];
end

auxf1
auxf2



    





