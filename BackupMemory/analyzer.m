%this is the baby maker.  It accepts a string input, compares it to two
%arrays: good and bad.  based on a THRESHOLD, it will determine if the
%input is positive (good) or negative (bad).  if it cannot determine, then
%it will request another input.  goodArray and badArray should be run
%through wordcount and wordfreq first. They each need to have the
%appropriate 3 columns that are generated using those functions.  Input can
%be any string.  currentScore is used if this analyzer is being rerun.
%Outcome is -1 (bad) or 0 (confused) or 1 (good).  words are written to xls
%memory.

function [outcome score words] = analyzer(goodArray,badArray,input,currentScore)
if nargin <4
    currentScore = 0; %current score is not mandatory. if one does not exist, reset
end
status = 'Please wait one moment while I analyze your response.';
speech(status);
disp(status)

%first, we need to parse the input.  remove punctuation, extra spaces.
str1 = strtrim(input);
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
output = [];

for wordIndex = 1:numberWords
    %check if last word
    if wordIndex == numberWords
        currentWord=str3(wordStart:length(str3));
    else
        currentWord = str3(wordStart:spaceIndex(wordIndex)-1);
        wordStart = spaceIndex(wordIndex)+1;  %set up start index for next word
    end
    
    %all we are doing is putting each currentWord as its own row in an
    %array.  this is stored to compare later against good and bad arrays
    output = [output; {currentWord}];
end


%now, let's find the goodScore and badScore.  We will store the words as
%well so we can add it to the library.
[num txt raw] = xlsread('mlinfo.xlsx');
mlInfo = txt{randi(length(txt))};
speech(mlInfo);

goodScore = [0];
goodWord =[];
badScore =[0];
badWord = [];
confusedScore = [0];
confusedWord = [];
%We are going to  step through each word in the INPUT and find it in
%goodArray.  When we have a match, we add COUNT to the score.
for index = 1:length(output)
   currentWord = output{index};
   if isempty(strmatch(currentWord,goodArray(2:length(goodArray),1),'exact'))==0 %is it good?
       outputInd = strmatch(currentWord,goodArray(2:length(goodArray),1),'exact');
       goodScore = [goodScore + goodArray{outputInd+1,2}]; %add the COUNT
       goodWord = [goodWord; {currentWord}];
   elseif isempty(strmatch(currentWord,badArray(2:length(badArray),1),'exact'))==0 %is it bad?
       outputInd = strmatch(currentWord,badArray(2:length(badArray),1),'exact');
       badScore = [badScore + badArray{outputInd+1,2}]; %add the COUNT
       badWord = [badWord; {currentWord}];
   else %when currentWord is not in good or bad array
       confusedScore = confusedScore + round(length(currentWord)/numberWords);
       confusedWord = [confusedWord; {currentWord}];
   end
end

%now, compare the three scores and output a decision.  Here you set the
%threshold for the CLASSIFICATION decision
total = sum([goodScore badScore confusedScore]);
if confusedScore >= goodScore && confusedScore>=badScore %if cannot distinguish because more confused than anything else
    outcome = 0;
    score = (confusedScore/total)*100;
    words = confusedWord;
elseif goodScore > confusedScore && goodScore > badScore
    outcome = 1;
    score = (goodScore/total)*100;
    words = goodWord;
elseif badScore > goodScore && badScore > goodScore
    outcome = -1;
    score = (badScore/total)*100;
    words = badWord;    
else %in this case, good and bad scores must be equal
    outcome = 0;
    score = (confusedScore/total)*100;
    words =confusedWord;
end

end