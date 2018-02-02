clear
clc
overview1 = 'Hello.  I am a set of algorithms built by Justin Nguyen.  Specifically, I analyze and learn from text that is fed to me, either by bulk import or by conversing with humans.';
overview2 = 'I am currently designed to read text and classify phrases based on my memory. When I interact with you, the end user, I save our experience to my memory.';
naiveBayes ='My knowledge is built, gathered, and controlled by an extensive library of datasets. Based on our interaction, I calculate probabilities by comparing them to previous interactions.  If you want to give me a direct learning set, please use good array and bad array';
example= 'If you would like to try me out, use the greeting function.  Just type in greeting. There is no need for any inputs.';
howTo = 'My algorithms are structured as a decision tree and ordered as follows. word count and word frequency, which are based on single word naive bayes algorithms. the baby maker is analyzer. then confusedNode only if needed';
termNodes = 'The terminal nodes are either goodNode or badNode. If I cannot solve your inputs, then I will either restart or ask you to try again.  If you have further questions, contact Justin Nguyen';

disp(overview1)
speech(overview1)
pressKey = 'Press any key then Enter to continue. Press enter to exit.';
response = input(pressKey, 's');
if isempty(response)==0
    disp(overview2)
    speech(overview2)
else
    return
end
    

response = input(pressKey,'s');
if isempty(response)==0
    disp(naiveBayes)
    speech(naiveBayes)
else
    return
end

response = input(pressKey,'s');
if isempty(response)==0
    disp(example)
    speech(example)
else
    return
end

response = input(pressKey,'s');
if isempty(response)==0
    disp(howTo)
    speech(howTo)
else
    return
end
    
response = input(pressKey,'s');
if isempty(response)==0
    disp(termNodes)
    speech(termNodes)
else
    return
end
clear
clc
    
