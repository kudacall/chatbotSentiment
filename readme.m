clear
clc
overview1 = 'Hello.  I am a set of algorithms built by Justin Nguyen.  Specifically, I analyze and learn from text, either by bulk import or by conversing with humans.';
overview2 = 'I am currently designed to read text and classify phrases based on my memory. When I interact with you, the end user, I save our experience to my memory.';
naiveBayes ='My knowledge is built, gathered, and controlled by an extensive library of datasets. Based on our interaction, I calculate probabilities by comparing them to previous interactions.  Thus, I am a supervised machine learning algorithm';
example= 'If you would like to try me out, use the demo method.  This will take you step by step through my analysis.  I will give you options at each node to continue, reverse, or jump branches completely.';
howTo = 'My algorithms are structured as a decision tree with several nodes.  You can train me manually or bulk import training sets.  Keep training me until you feel that I am accurate.';
termNodes = 'If I cannot solve your inputs with high confidence, then I will either restart or ask you to try again.  If you automate me, I will kick out low confidence guesses to an output file for review and more training.  If you have further questions, contact Justin Nguyen';

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
    
