function [] = speech(input)
%Speak and display greeting
sysspeech = NET.addAssembly('System.Speech');
ss = System.Speech.Synthesis.SpeechSynthesizer;
ss.Volume = 100;
ss.SelectVoice('Microsoft Hazel Desktop');
Speak(ss,input)
end
