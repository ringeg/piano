# piano
# 🎵 برنامج توليد النوتات والكوردات الموسيقية وملفات WAV

# 🎵 Musical Notes, Chords & WAV Generator

---

## 📘 العربية

### 📝 نظرة عامة

هذا المشروع يقوم بإنشاء ملفات صوتية بصيغة **WAV (PCM 16-bit, Mono, 44.1kHz)** باستخدام التوليد الرياضي للموجات الصوتية.

يدعم البرنامج:

* توليد جميع نوتات البيانو مع الترددات الصحيحة
* إنشاء كوردات موسيقية
* تحويل الكلمات إلى موسيقى
* دعم عدة أنواع موجات (Sine, Square, Saw, Triangle)
* تطبيق مؤثرات صوتية مثل ADSR و Vibrato و Chorus

---

### 🎹 توليد نوتات البيانو

* توليد النوتات من C0 إلى C8
* حساب التردد باستخدام المعادلة:

```
f = 440 * 2^((n)/12)
```

حيث A4 = 440Hz

الدوال:

* generateAllNotes()
* generatePianoNotes()

---

### 🎼 تحويل الحروف إلى كوردات

كل حرف إنجليزي يتم تحويله إلى كورد موسيقي مخصص.

مثال:

* A → A Major
* C → C Major
* M → Mellow Chord

الدالة:

```
getLetterChord(letter)
```

---

### 🔊 أنواع الموجات المدعومة

* sine (جيبية)
* square (مربعة)
* saw (سن منشار)
* triangle (مثلثية)

الدالة:

```
generateChordWave(frequencies, duration, sampleRate, waveformType)
```

---

### 🎚 غلاف ADSR الصوتي

المراحل:

* Attack
* Decay
* Sustain
* Release

الدوال:

* CreateEnvelope()
* applyADSR()

---

### 🎧 المؤثرات الصوتية

* Vibrato
* Chorus
* Fade In / Fade Out
* التحكم في مستوى الصوت

الدوال:

* applyVibrato()
* applyChorus()
* createChordSound()

---

### 📝 تحويل كلمة إلى موسيقى

يمكن تحويل كلمة كاملة إلى ملف WAV بحيث يمثل كل حرف كورد مختلف.

الدالة:

```
wordToMusic(word, outputFile)
```

مثال:

```
wordToMusic("MUSIC", "music.wav")
```

---

### 📁 إنشاء ملف WAV

يتم إنشاء ملف WAV قياسي يحتوي على:

* RIFF Header
* WAVE Format
* 16-bit PCM
* Mono Channel
* 44100 Hz

الدوال:

* SimpleWavCreator()
* writeWavFile()

---

### ⚙ الإعدادات الافتراضية

| الخاصية           | القيمة          |
| ----------------- | --------------- |
| Sample Rate       | 44100 Hz        |
| Bit Depth         | 16-bit          |
| Channels          | Mono            |
| مدة النوتة        | 0.3 – 0.8 ثانية |
| الصمت بين النوتات | 20–100ms        |

---

### 🚀 مثال تشغيل

```
SimpleWavCreator()
```

أو:

```
wordToMusic("HELLO", "hello.wav")
```

---

## 📘 English

### 📝 Overview

This project generates **WAV audio files (PCM 16-bit, Mono, 44.1kHz)** using mathematical waveform synthesis.

It supports:

* Generating full piano notes with correct frequencies
* Creating musical chords
* Converting words into music
* Multiple waveform types (Sine, Square, Saw, Triangle)
* Audio effects such as ADSR, Vibrato, and Chorus

---

### 🎹 Piano Note Generation

* Generates notes from C0 to C8
* Frequency calculation using:

```
f = 440 * 2^((n)/12)
```

Where A4 = 440Hz

Functions:

* generateAllNotes()
* generatePianoNotes()

---

### 🎼 Letter to Chord Mapping

Each English letter maps to a musical chord.

Examples:

* A → A Major
* C → C Major
* M → Mellow Chord

Function:

```
getLetterChord(letter)
```

---

### 🔊 Supported Waveforms

* sine
* square
* saw
* triangle

Function:

```
generateChordWave(frequencies, duration, sampleRate, waveformType)
```

---

### 🎚 ADSR Envelope

Stages:

* Attack
* Decay
* Sustain
* Release

Functions:

* CreateEnvelope()
* applyADSR()

---

### 🎧 Audio Effects

* Vibrato
* Chorus
* Fade In / Fade Out
* Volume control

Functions:

* applyVibrato()
* applyChorus()
* createChordSound()

---

### 📝 Word to Music

Convert a word into a WAV file where each letter becomes a chord.

Function:

```
wordToMusic(word, outputFile)
```

Example:

```
wordToMusic("MUSIC", "music.wav")
```

---

### 📁 WAV File Creation

Creates a standard WAV file with:

* RIFF Header
* WAVE Format
* 16-bit PCM
* Mono
* 44100 Hz

Functions:

* SimpleWavCreator()
* writeWavFile()

---

### ⚙ Default Settings

| Property              | Value         |
| --------------------- | ------------- |
| Sample Rate           | 44100 Hz      |
| Bit Depth             | 16-bit        |
| Channels              | Mono          |
| Note Duration         | 0.3 – 0.8 sec |
| Silence Between Notes | 20–100ms      |

---

### 🚀 Example Usage

```
SimpleWavCreator()
```

Or:

```
wordToMusic("HELLO", "hello.wav")
```

---

## 🏁 Output

The program generates:

* A WAV file containing generated notes or word-based music
* (Optional) A text file with note information

---

Ready to use as `README.md` file.
