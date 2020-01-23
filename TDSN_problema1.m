% -------------------------------
% Autor: Javier Sánchez Fernández
% -------------------------------


% 1. DEMODULACION SEÑAL FSK BINARIA

% 1.1. Preparacion del entorno de trabajo
close all
clear
load incognita

% 1.2. Espectrograma
signal = incognita;
window = 50;
noverlap = 0;
nfft = window.*3;
colormap('jet');
figure(1);
spectrogram(signal(1:600), window, noverlap, nfft);
xlabel('Frecuency');
ylabel('Time');
title('Espectrograma de la señal FSK binaria');

% 1.2. Recogida de valores
S = 0; F = 0; T = 0;
[S, F, T] = spectrogram(incognita, window, noverlap, nfft, fs);

% 1.3. Decodificamos la señal FSK binaria en funcion del valor de S
% obtenido.

l = length(S(1,:));
bits = zeros(1, l);
for i= 1:l
    if(max(abs(S(:,i))) < 13.272) % 13.2732 = '0'y 13.2711 = '1'
        bits(i) = 1;
    end
end

% 1.4. Imprimimos el mensaje por consola
message = binToTxt(bits);
message


% 2. DECODIFICACION SEÑAL DTMF

% Preparamos el entorno
clear
load telef2.mat

% 2.1. Definicion de constantes
f1_freqs = [704, 792, 872, 956];
f2_freqs = [1224, 1386, 1512];
window_DTMF = 400;
noverlap = 0;
nffs = window_DTMF.*3;

% 2.2. Representación del espectrograma
figure(2);
colormap('default')
spectrogram(telef, window_DTMF, noverlap, nffs, fs);

% 2.3. Calculo de la STFT
S = 0; F = 0; T = 0;
[S, F, T] = spectrogram(telef, window_DTMF, noverlap, nffs, fs);

% 2.4. Muestreo
sampled_S = zeros(601,1);
real_S = abs(S);
n = 2;           % vector donde iniciamos el muestreo
bound = (length(S(1,:)) - 3);
while n <= bound
    sampled_S = [sampled_S real_S(:,n)];
    n = n+5;    % muestreamos cada 5 posiciones
end

sampled_S = sampled_S(:, 2:end); % elimino la primera columna de ceros, residuo de la inicilización.


% 2.5. Creamos dos matrices que contienen las frecuencias f1 y f2 presentes
% en cada muestra

auxf1= [];
auxf2=[];

k = length(S(1,:))/5;
for j = 1:k
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

% 2.6. Decodificamos las frecuencias presentes en cada muestra segun la tabla
telef = [''];
for m = 1:k
    f1m = auxf1(m,:);
    f2m = auxf2(m,:);
    
    if ((f1m(1) == 1) & (f2m(1)==1))
        telef = [telef '1'];
    elseif ((f1m(1) == 1) & (f2m(2)==1))
        telef = [telef '2'];
    elseif ((f1m(1) == 1) & (f2m(3)==1))
        telef = [telef '3'];
    elseif ((f1m(2) == 1) & (f2m(1)==1))
        telef = [telef '4'];
    elseif ((f1m(2) == 1) & (f2m(2)==1))
        telef = [telef '5'];
    elseif ((f1m(2) == 1) & (f2m(3)==1))
        telef = [telef '6'];
    elseif ((f1m(3) == 1) & (f2m(1)==1))
        telef = [telef '7'];
    elseif ((f1m(3) == 1) & (f2m(2)==1))
        telef = [telef '8'];
    elseif ((f1m(3) == 1) & (f2m(3)==1))
        telef = [telef '9'];
    elseif ((f1m(4) == 1) & (f2m(1)==1))
        telef = [telef '#'];
    elseif ((f1m(4) == 1) & (f2m(2)==1))
        telef = [telef '0'];
    elseif ((f1m(4) == 1) & (f2m(3)==1))
        telef = [telef '*'];
    end
end

% 2.7. Imprimo por consola el número de teléfono obtenido
telephone = telef



    





