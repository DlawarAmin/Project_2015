
function binVector = str2bin(textStr)

% STR2BIN Convert text string to binary vector



    AsciiCode = uint8(textStr);
    
    binStr = transpose(dec2bin(AsciiCode,8));
    binStr = binStr(:);
    
    N = length(binStr);
    binVector = zeros(N,1);

    for k = 1:N
        binVector(k) = str2double(binStr(k));
    end

    binVector = logical(binVector);

end
