%%This function inputs a xls or csv file, where each row is a string.  This
%%function will first trim white space, then put each word as a row in an
%%array with the count and freq %.  The input is a single column of strings
%%The output can be used to produce a
%%word graph, or as an input to sentiment analysis.  

function [output] = wordcount(input)
output = [{'Word'} {'Count'}];
[num txt raw] = xlsread(input);

%Each word will be written to the output.  First, let's parse each line.
stringCount = length(txt);
for index = 1:stringCount
    currentString = txt{index};%Current line/string
    str1 = strtrim(currentString); %trim leading and following spaces
    
    %remove punctuation below
    str_space='\s';
    str_caps='[A-Z]';
    str_ch='[a-z]';
    str_nums='[0-9]';
    ind_space=regexp(str1,str_space);
    ind_caps=regexp(str1,str_caps);
    ind_chrs=regexp(str1,str_ch);
    ind_nums=regexp(str1,str_nums);
    mask=[ind_space ind_caps ind_chrs ind_nums];
    num_str2=1:1:length(str1);
    num_str2(mask)=[];
    str3=str1;
    str3(num_str2)=[];
    str3=regexprep(str3,' +', ' '); % removes extra spaces between words
    
    %Now we have words only in str3.  Time to parse and store.
    spaceIndex = strfind(str3,' ');%find indices of spaces
    numberWords = length(spaceIndex)+1; %number of words
    wordStart = 1;

    for wordIndex = 1:numberWords
        %check if last word
        if wordIndex == numberWords
            currentWord=str3(wordStart:length(str3));
        else
            currentWord = str3(wordStart:spaceIndex(wordIndex)-1);
            wordStart = spaceIndex(wordIndex)+1;  %set up start index for next word
        end
        
        %Start counting currentWord below
        if length(currentWord)<3
            disp(['Skipping one and two letter word:' ' ' currentWord])
        elseif isempty(strmatch(currentWord,output(:,1),'exact'))==0 %currentWord is in output
            outputInd = strmatch(currentWord,output(:,1),'exact'); %find index in output
            output{outputInd,2} = output{outputInd,2}+1; %add 1 to count column
        elseif isempty(strmatch(currentWord,output(:,1)))==1 %currentword not yet in output
            output = [output; {currentWord} {1}]; %add currentWord
        else
            output = [output; {currentWord} {1}];
        end
        
    end
    
    %now we have the word and the count.  we need to calculate the %
    %frequency, let's use the freq function

end