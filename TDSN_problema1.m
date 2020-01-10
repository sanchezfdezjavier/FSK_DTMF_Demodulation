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

colormap('default');
figure(1);
spectrogram(signal(1:600), window, noverlap, nfft);
xlabel('Frecuency [Hz]');
ylabel('Time [s]');
title('Espectrogram');

% Recogida de valores

S = 0;
F = 0;
T = 0;

[S, F, T] = spectrogram(incognita, window, noverlap, nfft, fs);

% Obtenemos la ristra de bits

bits = zeros(1, 9600);

for i= 1:9600
    if(max(abs(S(:,i))) < 13.272) % 13.2732 = '0'y 13.2711 = '1'
        bits(i) = 1;
    end
end


% Funcion bit2txt

char_bin = char(bits + '0');
char(bin2dec(char_bin(1:8))); % Output: 'E'

char_bin_reshaped = reshape(char_bin, 1200, 8);

final_string = '';

%reshape experimental

for j = 1:1200
    final_string(1,i) = char(bin2dec(char_bin_reshaped(j,:)));
end

    
    
