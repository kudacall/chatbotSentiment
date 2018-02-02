%%this function accepts a 2 column array.  column 1 has a word, in str.
%%column 2 has a count.  this function calculates the freq % in column 1 of
%%a word or phrase within the input array.  the frequency % is written to a
%%new column, column 3.  all 3 columns are written to the output

function [output] = wordfreq(array)

%first, calculate the sum of column 2, or the total count
vec=[array{2:length(array),2}]; %start at row 2.  row 1 is 'header' or column title.
totalCount = sum(vec);

%for each row in column 1, calculate the frequency % and append to 3rd
%column.  start at row 2 because row is head or column title

output=array;
for index = 2:length(array)
    output{index,3} = (output{index,2}/totalCount)*100;
end

%sort by descending frequency
temp = output(2:length(output),:); %remove headers so you can sort only on values
output = sortrows(temp,3);
output = flipud(output);
output = [{'Word'} {'Count'} {'Frequency %'};output];


end