%this algorithm accepts in a positive score from ANALYZER and confirms a
%GOOD response.  It will then write the words input to memory.
function [output] = confusedNode(score,words,response)
%response is an optional field
if nargin < 3
    response = [];
end

stringScore = num2str(score);
guess = ['Well well well. How interesting. According to my memory and calculations, I lack ' stringScore ' ' 'percent confidence in my classification algorithm.'];
speech(guess)
disp(guess)
teachQ = 'Lets fix this, shall we?  Will you teach me?';
speech(teachQ);
teachA = input(teachQ,'s');
if isempty(strfind(teachA,'ye'))==0
    ending = 'Thank you. Lets begin.  ';
    disp(ending)
    speech(ending);
elseif isempty(strfind(teachA,'no'))==0
    ending = 'Okay then.  Sorry to disappoint you.';
    disp(ending)
    speech(ending);
    output = ending;
    return
else
    user = 'Well sorry, I am not quite sure I understand.  We should try again some other time so I can learn.';
    disp(user)
    speech(user);
    output = user;
    return
end

%if the script is still continuing at this point, the if statement above
%was satisfied and the end user has agreed to teach the algorithm and add
%to its memory.
%first, the end user needs to tell the algorithm is their response was good
%or bad.
classifyQ = ['First, can you tell me if your response was good or bad? Type either "good" for good or "bad" for bad: ' ' '];
speech(classifyQ)
classifyA = input(classifyQ,'s');
if isempty(strfind(classifyA,'goo'))==0
    outcome=1;
elseif isempty(strfind(classifyA,'ba'))==0
    outcome=-1;
else
    user = 'Well sorry, I am not quite sure I understand.  We should try again some other time so I can learn.';
    disp(user)
    speech(user);
    output = user;
    return
end
%second, the end user needs to tell the algorithm which words specifically
%to add to the memory.
wordQ = ['Now can you tell me which words I should associate your sentiment with?  Some words are outside my vocabulary.' ' '];
speech(['Got it. Thank you.' '  ' wordQ])
response = response
wordA = input(wordQ,'s');
if isempty(wordA)==0 
    %first, we need to parse the input.  remove punctuation, extra spaces.
    str1 = strtrim(wordA);
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
    words = [];

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
        words = [words; {currentWord}];
    end    
else
    ending = 'You did not put in any values. I am sorry, but I cannot learn unless you teach me.';
    speech(ending)
    disp(ending)
    return
end


%The user is manually overwriting to the algorithm's memory at this point.
%confirm with the end user to make sure this is intendded and deliberate
confirmQ = ['Your response was ' classifyA ' ' 'and the words I should add to my memory are' ' ' wordA ' ' 'Is this correct?  Answer yes or no:' ' '];
speech(['Thank you. Lets recap, shall we.' '  ' confirmQ]);
add_to_vocab = words
confirmA = input(confirmQ,'s');
if isempty(strfind(confirmA,'no'))==0
    ending = 'Okay then.  I will not add new vocabulary to my memory.';
    disp(ending)
    speech(ending);
    output = ending;
    return
elseif isempty(strfind(confirmA,'ye'))==1
    ending = 'Okay then.  I will not add new vocabulary to my memory.';
    disp(ending)
    speech(ending);
    output = ending;
    return
else
    ending = 'Great!  I am adding this to my memory.  Lets recalculate, shall we.';
    disp(ending)
    speech(ending)
end

%The outcome is either -1 (bad) or 1 (good).  The outcome
%determines which node to go to next.
score = 100;
if outcome==1
    output = goodNode(score, words);
elseif outcome ==-1
    output = badNode(score, words);
else
    speech('Error.  I am lost.  See my greeting algorithm')
end

output = ending;
end