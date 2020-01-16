function [bit] = does_freq_exists(real)
% This value returns '1' if the input value is larger than the threshold
% and 0 when others
if real > 42
    bit = 1;
else
    bit = 0;
end

