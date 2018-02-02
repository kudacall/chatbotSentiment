function [] = greeting()
clear
clc
[num txt raw] = xlsread('greetings1.xlsx'); %imports greeting
greet = txt{randi(length(txt))}; %picks random greeting

%Speak and display greeting
sysspeech = NET.addAssembly('System.Speech');
ss = System.Speech.Synthesis.SpeechSynthesizer;
ss.Volume = 100;
ss.SelectVoice('Microsoft Hazel Desktop');
Speak(ss,greet)
response = input(greet,'s'); 
if isempty(response)==0
    return
end
%Now, we are going to take the response and send it to ANALYZER.  ANALYZER
%requires a goodArray and a badArray, which we will feed in here below
%using the wordcount and wordfreq functions.
tempGood = wordcount('good.xlsx');
goodArray = wordfreq(tempGood);
tempBad = wordcount('bad.xlsx');
badArray = wordfreq(tempBad);

[outcome score words] = analyzer(goodArray,badArray,response);
%The outcome is either -1 (bad) or 0 (confused) or 1 (good).  The outcome
%determines which node to go to next.
if outcome==1
    output = goodNode(score, words,response);
elseif outcome==0
    output = confusedNode(score, words, response);
elseif outcome ==-1
    output = badNode(score, words,response);
else
    speech('Error.  I am lost.  See my greeting algorithm')
end

ending = 'Thank you for taking time to teach me today. I will add our interaction to my memory and learn from our experience.';
disp(ending)
speech([ending '  ' 'Goodbye for now.']);
end