function [text] = binToTxt(bin_message)

% binToTxt convierte cadena de bits en cadena de texto
% text = string
% bin_message = vector binario a descodificar

    bits_reshaped_bin = reshape(bin_message, 8, length(bin_message)/8)';
    bits_reshaped_char = char(bits_reshaped_bin + '0');
    message = char(bin2dec(bits_reshaped_char))';
    text = message;
end

