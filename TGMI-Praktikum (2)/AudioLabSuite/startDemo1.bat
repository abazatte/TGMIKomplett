SET PATH=.;%PATH%
START "" Signalgenerator sig_generated.wav
START "" Oscilloscope sig_generated.wav 
START "" Filter sig_generated.wav filtered.wav coeff.txt
START "" Oscilloscope filtered.wav 
START "" Spectrumanalyzer filtered.wav 
START "" Playback filtered.wav 