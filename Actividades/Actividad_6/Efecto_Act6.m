
fileReader = dsp.AudioFileReader('Jazz_2516_Tarea.wav','SamplesPerFrame',44100);
deviceWriter = audioDeviceWriter('SampleRate',fileReader.SampleRate);

tic
while toc < 10
    audio = fileReader();
    deviceWriter(audio);
end
release(fileReader)

reverb = reverberator

scope = timescope( ...
    'SampleRate',fileReader.SampleRate,...
    'TimeSpanOverrunAction','Scroll',...
    'TimeSpanSource','property',...
    'TimeSpan',3,...
    'BufferLength',3*fileReader.SampleRate*2, ...
    'YLimits',[-1,1],...
    'ShowGrid',true, ...
    'ShowLegend',true, ...
    'Title','Audio with Reverberation vs. Original');

while ~isDone(fileReader)
    audio = fileReader();
    audioWithReverb = reverb(audio);
    deviceWriter(audioWithReverb);
    scope([audioWithReverb(:,1),audio(:,1)])
end
release(fileReader)
release(deviceWriter)
release(scope)


parameterTuner(reverb)