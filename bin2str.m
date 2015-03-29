
function textStr = bin2str(binVector)
% STR2BIN Convert binary vector to text string

    binValues = [128 64 32 16 8 4 2 1];
    
    binVector = binVector(:);
    
    if mod(length(binVector),8) ~= 0
        error('Length of binary vector is not a multiple of 8.');
    end
    
    binMatrix = reshape(binVector,8,[]);
    
    textStr = char(binValues * logical(binMatrix));
    

end

