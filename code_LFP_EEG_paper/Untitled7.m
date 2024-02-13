inputStrings=bin_label_ref;
bin_label_ref_=bin_label_ref;
% Iterate through each element in the input array
for i = 1:numel(bin_label_ref)
    % Replace 'AA' with 'CC' using the strrep function
    modifiedString = strrep(inputStrings(i), 'REM', 'SWS');

    modifiedString = strrep(inputStrings(i), 'IS', 'REM');

    
    % Store the modified string in the output array
    bin_label_ref_(i) = modifiedString;
end