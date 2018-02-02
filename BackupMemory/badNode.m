%this algorithm accepts in a positive score from ANALYZER and confirms a
%BAD response.  It will then write the words input to memory.
function [output] = badNode(score,words,response)
%response is an optional field
if nargin < 3
    response = [];
end

stringScore = num2str(score);
guess = ['I am sorry, but it does not sound like you are doing well. According to my memory and calculations, there is a ' stringScore ' ' 'percent chance of this.'];
speech(guess)
disp(guess)
question = 'Would you say that I am correct?';
speech(question);
response = input(question,'s');

if isempty(strfind(response,'ye'))==0
    ending = 'I will learn some good jokes to tell you in the future to make you feel better.  I am adding this to my memory and I will continue to learn.';
    disp(ending)
    speech(ending);
    [num txt raw] = xlsread('bad.xlsx');
    newBad = [txt; words];
    xlswrite('bad.xlsx',newBad);
    speech(['I recommend reaching out to Justin Nguyen.  When I am feeling down, he usually makes me feel better.  He may make you feel better as well.'])
elseif isempty(strfind(response,'no'))==0
    ending = 'Sorry, that is my error. My learning set is too controlled, or maybe it is corrupted.';
    disp(ending)
    speech(ending);
    disp('Misleading words that were used:')
    words
    score = 100;
    confusedNode(score,words,response)
else
    user = 'Well sorry, I am not quite sure I understand.  We should try again some other time so I can learn.';
    disp(user)
    speech(user);
end

output = ending;
end