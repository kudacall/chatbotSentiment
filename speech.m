function [] = speech(input)
% %Speak and display greeting
% sysspeech = NET.addAssembly('System.Speech');
% ss = System.Speech.Synthesis.SpeechSynthesizer;
% ss.Volume = 100;
% ss.Rate = 0.5;%1; %this speeds up the normal speed by 3
% ss.SelectVoice('Microsoft Hazel Desktop');
% Speak(ss,input)
system( sprintf('say -v Tessa %s', input) );
end
