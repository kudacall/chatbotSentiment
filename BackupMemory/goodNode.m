%this algorithm accepts in a positive score from ANALYZER and confirms a
%GOOD response.  It will then write the words input to memory.
function [output] = goodNode(score,words,response)
%response is an optional field
if nargin < 3
    response = [];
end

stringScore = num2str(score);
guess = ['It sounds like you are in a great mood. According to my memory and calculations, there is a ' stringScore ' ' 'percent chance of this.'];
speech(guess)
disp(guess)
question = ['Would you say that I am correct?' ' '];
speech(question);
answer = input(question,'s');

if isempty(strfind(answer,'ye'))==0
    ending = 'You cannot tell from my tone but that is wonderful.  I am adding this to my memory and I will continue to learn.';
    disp(ending)
    speech(ending);
    [num txt raw] = xlsread('good.xlsx');
    newGood = [txt; words];
    xlswrite('good.xlsx',newGood);
elseif isempty(strfind(answer,'no'))==0
    ending = 'Sorry, that is my error. My learning set is too controlled and needs to expand.';
    disp(ending)
    speech(ending);
    disp('Misleading words that were used:')
    words
    confusedNode(100,words,response)
else
    user = 'Well sorry, I am not quite sure I understand.  We should try again some other time so I can learn.';
    disp(user)
    speech(user);
end

output = ending;
end