# The Main File

load "lib.ring"

func main
// كورد A Major
sampleRate = 44100

frequencies = [440.00, 554.37, 659.25]

// 1. موجة جيبية بسيطة
wave1 = generateChordWave(frequencies, 1.0, sampleRate, "sine")

// 2. موجة مربعة
wave2 = generateChordWave(frequencies, 1.0, sampleRate, "square")

// 3. مع خيارات متقدمة
options = [
    "waveform", "sine",
    "volume", 0.8,
    "fadeIn", 0.05,
    "fadeOut", 0.1,
    "vibrato", true
]
wave3 = createChordSound(frequencies, 1.0, sampleRate, options)
see wave3
wav2Flie("wave3.wav",wave2,sampleRate)
see copy("*",50)+nl
wordToMusic("ABCD","Major.wav")
see copy("*",50)+nl
SimpleWavCreator()

