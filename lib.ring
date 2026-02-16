# The Library File
// نسخة محسنة لإنشاء ملف WAV للنوتات c1, c3, a1// مثال سريع للاستخدام:
sampleRate = 44100

func getMap(m,key,defaultValue)
if(m[key])
return m[key]
else
return defaultValue
end

func generateAllNotes()
    notesNames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    allNotes = []
    
    // نطاق البيانو القياسي: A0 إلى C8 (88 مفتاح)
    // لكن سنولد من C0 إلى C8 للتوافق مع الترميز
    
    for octave = 0 to 8
        for i = 1 to len(notesNames)
            noteName = notesNames[i]
            
            // تخطي بعض النوتات في الأوكتافات المنخفضة والعالية
            // (البيانو الحقيقي له بداية ونهاية محددة)
            if octave = 0
                // في الأوكتاف 0، البيانو يبدأ من A0
                if noteName = "C" or noteName = "C#" or noteName = "D" or noteName = "D#"
                    loop
                ok
            ok
            
            if octave = 8
                // في الأوكتاف 8، البيانو ينتهي عند C8
                if noteName = "C#" or noteName = "D" or noteName = "D#" or 
                   noteName = "E" or noteName = "F" or noteName = "F#" or
                   noteName = "G" or noteName = "G#" or noteName = "A" or 
                   noteName = "A#" or noteName = "B"
                    loop
                ok
            ok
            
            fullNoteName = noteName + string(octave)
            
            // حساب التردد باستخدام الصيغة الصحيحة
            // A4 = 440 هرتز (مفتاح البيانو رقم 49)
            
            // حساب رقم المفتاح (key number)
            // C0 يعتبر المفتاح رقم 0 في بعض الأنظمة
            // لكن في نظام بيانو قياسي: A4 = مفتاح 49
            keyNumber = 0
            
            // البحث عن مؤشر النوتة (0-based)
            noteIndex = 0
            for j = 1 to len(notesNames)
                if notesNames[j] = noteName
                    noteIndex = j - 1
                    exit
                ok
            next
            
            // حساب رقم المفتاح بناءً على C0 = 0
            // C0 = 0, C#0 = 1, D0 = 2, ..., B0 = 11
            // C1 = 12, C2 = 24, وهكذا
            keyNumber = (octave * 12) + noteIndex
            
            // لكننا نحتاج لتحويله إلى نظام A4 = 49
            // A4 هي النوتة رقم 57 في نظام C0 = 0
            // لأن A4 = (4 * 12) + 9 = 57 (حيث A هو المؤشر 9)
            
            // الصيغة الصحيحة: f = 440 * 2^((n - 49)/12)
            // حيث n هو رقم المفتاح في نظام A4 = 49
            
            // تحويل من نظام C0=0 إلى نظام A4=49
            // C0 (keyNumber=0) يكافئ n = -9 في نظام A4=49
            // لأن A0 = keyNumber=9
            
            // أسهل طريقة: استخدام A4 كمقياس
            // الفرق في الأوكتافات عن A4
            semitonesFromA4 = (octave - 4) * 12 + (noteIndex - 9)  // 9 لأن A هو المؤشر 9
            
            // حساب التردد
            frequency = 440.0 * pow(2, semitonesFromA4 / 12.0)
            
            // تقريب التردد
            //frequency = round(frequency * 100) / 100
            
            allNotes + [fullNoteName, frequency]
        next
    next
    
    return allNotes
end


func getLetterChord(letter)
    letter = upper(letter)
    
    // تعريف الكورادات (كل حرف = 3-4 نوتات)
    chords = [
        // الحروف المتحركة (Vowels) - نغمات أكثر نقاءً
        ["A", [440.00, 554.37, 659.25, 880.00]],   // A Major
        ["E", [329.63, 415.30, 493.88, 659.25]],   // E Minor
        ["I", [261.63, 329.63, 392.00, 523.25]],   // C Major
        ["O", [392.00, 493.88, 587.33, 783.99]],   // G Major
        ["U", [349.23, 440.00, 523.25, 698.46]],   // F Major
        
        // الحروف الساكنة (Consonants) - أصوات أكثر تعقيداً
        ["B", [246.94, 311.13, 369.99]],           // B Diminished
        ["C", [261.63, 329.63, 392.00]],           // C Major
        ["D", [293.66, 369.99, 440.00]],           // D Minor
        ["F", [349.23, 440.00, 523.25]],           // F Major
        ["G", [392.00, 493.88, 587.33]],           // G Major
        ["H", [246.94, 293.66, 349.23]],           // H Minor
        ["J", [233.08, 293.66, 349.23]],           // J Augmented
        ["K", [329.63, 415.30, 523.25]],           // K Suspended
        ["L", [146.83, 174.61, 220.00]],           // L Low
        ["M", [220.00, 277.18, 329.63]],           // M Mellow
        ["N", [233.08, 293.66, 349.23]],           // N Nasal
        ["P", [196.00, 246.94, 293.66]],           // P Plosive
        ["Q", [311.13, 392.00, 466.16]],           // Q Unique
        ["R", [277.18, 349.23, 415.30]],           // R Rolling
        ["S", [369.99, 466.16, 554.37]],           // S Hissing
        ["T", [196.00, 246.94, 311.13]],           // T Stop
        ["V", [130.81, 164.81, 196.00]],           // V Voiced
        ["W", [164.81, 207.65, 246.94]],           // W Glide
        ["X", [233.08, 293.66, 369.99]],           // X Complex
        ["Y", [329.63, 392.00, 493.88]],           // Y Semi-vowel
        ["Z", [466.16, 587.33, 739.99]]            // Z Buzzing
    ]
    
    for chord in chords
        if chord[1] = letter
            return chord[2]
        ok
    next
    
    // القيمة الافتراضية إذا لم يوجد الحرف
    return [440.00, 523.25, 659.25]  // A Major Chord
end

// ============= دالة بديلة مبسطة =============
func generatePianoNotes()
    // نوتات البيانو الأساسية (88 مفتاح) مع تردداتها الصحيحة
    pianoNotes = [
        ["A0", 27.50], ["A#0", 29.14], ["B0", 30.87],
        ["C1", 32.70], ["C#1", 34.65], ["D1", 36.71], ["D#1", 38.89], 
        ["E1", 41.20], ["F1", 43.65], ["F#1", 46.25], ["G1", 49.00], 
        ["G#1", 51.91], ["A1", 55.00], ["A#1", 58.27], ["B1", 61.74],
        ["C2", 65.41], ["C#2", 69.30], ["D2", 73.42], ["D#2", 77.78], 
        ["E2", 82.41], ["F2", 87.31], ["F#2", 92.50], ["G2", 98.00], 
        ["G#2", 103.83], ["A2", 110.00], ["A#2", 116.54], ["B2", 123.47],
        ["C3", 130.81], ["C#3", 138.59], ["D3", 146.83], ["D#3", 155.56], 
        ["E3", 164.81], ["F3", 174.61], ["F#3", 185.00], ["G3", 196.00], 
        ["G#3", 207.65], ["A3", 220.00], ["A#3", 233.08], ["B3", 246.94],
        ["C4", 261.63], ["C#4", 277.18], ["D4", 293.66], ["D#4", 311.13], 
        ["E4", 329.63], ["F4", 349.23], ["F#4", 369.99], ["G4", 392.00], 
        ["G#4", 415.30], ["A4", 440.00], ["A#4", 466.16], ["B4", 493.88],
        ["C5", 523.25], ["C#5", 554.37], ["D5", 587.33], ["D#5", 622.25], 
        ["E5", 659.25], ["F5", 698.46], ["F#5", 739.99], ["G5", 783.99], 
        ["G#5", 830.61], ["A5", 880.00], ["A#5", 932.33], ["B5", 987.77],
        ["C6", 1046.50], ["C#6", 1108.73], ["D6", 1174.66], ["D#6", 1244.51], 
        ["E6", 1318.51], ["F6", 1396.91], ["F#6", 1479.98], ["G6", 1567.98], 
        ["G#6", 1661.22], ["A6", 1760.00], ["A#6", 1864.66], ["B6", 1975.53],
        ["C7", 2093.00], ["C#7", 2217.46], ["D7", 2349.32], ["D#7", 2489.02], 
        ["E7", 2637.02], ["F7", 2793.83], ["F#7", 2959.96], ["G7", 3135.96], 
        ["G#7", 3322.44], ["A7", 3520.00], ["A#7", 3729.31], ["B7", 3951.07],
        ["C8", 4186.01]
    ]
    
    return pianoNotes
end


func CreateEnvelope(numSamples)
        envelope = []
        attack = floor(numSamples * 0.05)    // 5% هجوم
        decay = floor(numSamples * 0.1)      // 10% اضمحلال
        sustain = floor(numSamples * 0.7)    // 70% استمرارية
        release = floor(numSamples * 0.15)   // 15% تحرير
        
        // مرحلة الهجوم (من 0 إلى 1)
        for i = 1 to attack
            envelope + (i / attack)
        next
        
        // مرحلة الاضمحلال (من 1 إلى 0.7)
        for i = 1 to decay
            envelope + (1 - (0.3 * (i / decay)))
        next
        
        // مرحلة الاستمرارية (0.7 ثابت)
        for i = 1 to sustain
            envelope + 0.7
        next
        
        // مرحلة التحرير (من 0.7 إلى 0)
        for i = 1 to release
            envelope + (0.7 * (1 - (i / release)))
        next
        
        return envelope
    end
    

func SimpleWavCreator()
    fp = fopen("simple_output.wav", "wb")
    
    // إعدادات محسنة
    sampleRate = 44100
    duration = 0.8  // زيادة المدة قليلاً
    amplitude = 28000  // زيادة السعة مع ترك هامش
    Piano=generatePianoNotes()
    // تعريف النوتات وتردداتها بدقة أعلى
    notes = [
        "c1",   
        "c3",  
      //  "a1",
        "c1",   
      //  "c3",  
        "a1"
    ]
    
        notes = [
         "C0",  "C#0",  "D0",  "D#0",
        "E0",  "F0",  "F#0", "G0",
         "G#0",  "A0", "A#0",  "B0",
         "C1",  "C#1",  "D1", "D#1",
         "E1",  "F1", "F#1", "G1",
         "G#1",  "A1",  "A#1",  "B1",
        "C2",  "C#2",  "D2", "D#2",
         "E2",  "F2",  "F#2", "G2",
         "G#2", "A2", "A#2", "B2",
         "C3",  "C#3", "D3", "D#3",
         "E3", "F3",  "F#3", "G3",
         "G#3",  "A3",  "A#3", "B3",
         "C4", "C#4",  "D4", "D#4",
         "E4",  "F4",  "F#4", "G4",
         "G#4",  "A4", "A#4", "B4",
         "C5", "C#5", "D5", "D#5",
         "E5",  "F5",  "F#5", "G5",
         "G#5",  "A5", "A#5", "B5",
         "C6",  "C#6",  "D6", "D#6",
         "E6",  "F6", "F#6", "G6",
         "G#6",  "A6", "A#6", "B6"
    ]
    
    // دالة لإنشاء غلاف سمعي (ADSR Envelope)
    
    // توليد البيانات المحسنة
    data = []
    for note in notes
        freq = Piano[note]
        numSamples = floor(duration * sampleRate)
        
        // إنشاء الغلاف السمعي لهذه النوتة
        envelope = CreateEnvelope(numSamples)
        
        // إضافة ترددات توافقية (Harmonics) لصوت أكثر ثراءً
        for i = 0 to numSamples - 1
            t = i / sampleRate
            
            // موجة جيبية أساسية مع توافقيات
            sample = 0.6 * sin(2 * 3.14159265359 * freq * t) +          // التوافقي الأساسي
                    0.3 * sin(2 * 3.14159265359 * freq * 2 * t) +      // التوافقي الثاني
                    0.1 * sin(2 * 3.14159265359 * freq * 3 * t)        // التوافقي الثالث
            
            // تطبيق الغلاف السمعي
            sample = sample * envelope[i + 1] * amplitude
            
            // قص العينات لتجنب التشويه
            if sample > 32767
                sample = 32767
            ok
            if sample < -32768
                sample = -32768
            ok
            
            // تطبيق توهج بسيط (Fade in/out) لكل نوتة
            if i < 100  // Fade in أول 100 عينة
                sample = sample * (i / 100)
            ok
            if i > numSamples - 100  // Fade out آخر 100 عينة
                sample = sample * ((numSamples - i) / 100)
            ok
            
            data + floor(sample)
        next
        
        // إضافة صمت قصير بين النوتات (20ms)
        silenceSamples = floor(0.02 * sampleRate)
        for i = 1 to silenceSamples
            data + 0
        next
    next
    
    // حساب الأحجام
    dataSize = len(data) * 2
    fileSize = dataSize + 36
    
    // كتابة الـ Header بدقة أعلى
    fwrite(fp, "RIFF")
    // ChunkSize (36 + SubChunk2Size)
    fwrite(fp, char(fileSize & 0xFF))
    fwrite(fp, char((fileSize >> 8) & 0xFF))
    fwrite(fp, char((fileSize >> 16) & 0xFF))
    fwrite(fp, char((fileSize >> 24) & 0xFF))
    
    fwrite(fp, "WAVE")
    
    // Format Subchunk
    fwrite(fp, "fmt ")
    fwrite(fp, char(16))  // Subchunk1Size = 16
    fwrite(fp, char(0))
    fwrite(fp, char(0))
    fwrite(fp, char(0))
    
    fwrite(fp, char(1))   // AudioFormat = 1 (PCM)
    fwrite(fp, char(0))
    
    fwrite(fp, char(1))   // NumChannels = 1 (Mono)
    fwrite(fp, char(0))
    
    // SampleRate = 44100
    fwrite(fp, char(0x44))
    fwrite(fp, char(0xAC))
    fwrite(fp, char(0))
    fwrite(fp, char(0))
    
    // ByteRate = SampleRate * NumChannels * BitsPerSample/8
    // = 44100 * 1 * 2 = 88200
    fwrite(fp, char(0x88))
    fwrite(fp, char(0x58))
    fwrite(fp, char(0x01))
    fwrite(fp, char(0))
    
    // BlockAlign = NumChannels * BitsPerSample/8 = 1 * 2 = 2
    fwrite(fp, char(2))
    fwrite(fp, char(0))
    
    // BitsPerSample = 16
    fwrite(fp, char(16))
    fwrite(fp, char(0))
    
    // Data Subchunk
    fwrite(fp, "data")
    // Subchunk2Size = NumSamples * NumChannels * BitsPerSample/8
    fwrite(fp, char(dataSize & 0xFF))
    fwrite(fp, char((dataSize >> 8) & 0xFF))
    fwrite(fp, char((dataSize >> 16) & 0xFF))
    fwrite(fp, char((dataSize >> 24) & 0xFF))
    
    // كتابة البيانات مع التحقق
    writtenSamples = 0
    for sample in data
        // التحقق من النطاق
        if sample > 32767 sample = 32767 ok
        if sample < -32768 sample = -32768 ok
        
        // تحويل إلى 16-bit signed (Little Endian)
        s = sample & 0xFFFF
        fwrite(fp, char(s & 0xFF))
        fwrite(fp, char((s >> 8) & 0xFF))
        writtenSamples = writtenSamples + 1
    next
    
    fclose(fp)
    
    // معلومات عن الملف المنشأ
    see "====================================" + nl
    see "تم إنشاء ملف WAV بنجاح!" + nl
    see "اسم الملف: simple_output.wav" + nl
    see "مدة الصوت: " + string((len(data) / sampleRate)) + " ثانية" + nl
    see "عدد العينات: " + string(len(data)) + nl
    see "النوتات: " + nl
    see notes
    see "معدل العينات: " + string(sampleRate) + " هرتز" + nl
    see "الدقة: 16-bit" + nl
    see "القنوات: أحادي (Mono)" + nl
    see "====================================" + nl
    
    // إنشاء ملف نصي مع معلومات عن النوتات
    // CreateNoteInfoFile(notes)
end

func generateChordWave(frequencies, duration, sampleRate, waveformType )
    /*
    معاملات الدالة:
      frequencies: قائمة الترددات (مثل [440, 554, 659])
      duration: مدة الصوت بالثواني
      sampleRate: معدل العينات (مثل 44100)
      waveformType: نوع الموجة ("sine", "square", "saw", "triangle")
    */
    
    numSamples = floor(duration * sampleRate)
    wave = list(numSamples)
    
    // إعدادات حسب نوع الموجة
    if waveformType = "square"
        // موجة مربعة
        for i = 0 to numSamples - 1
            t = i / sampleRate
            sample = 0
            
            for freq in frequencies
                // موجة مربعة = sin(ωt) + 1/3 sin(3ωt) + 1/5 sin(5ωt) + ...
                for harmonic = 1 to 5 step 2  // التوافقيات الفردية فقط
                    omega = 2 * 3.14159265359 * freq
                    sample += (1.0 / harmonic) * sin(omega * harmonic * t)
                next
            next
            
            // تطبيع ومضاعفة
            sample = sample / (len(frequencies) * 1.5)
            wave[i + 1] = floor(sample * 28000)
        next
        
    elseif waveformType = "saw"
        // موجة سن المنشار
        for i = 0 to numSamples - 1
            t = i / sampleRate
            sample = 0
            
            for freq in frequencies
                // موجة سن المنشار = sin(ωt) - 1/2 sin(2ωt) + 1/3 sin(3ωt) - ...
                for harmonic = 1 to 8
                    omega = 2 * 3.14159265359 * freq
                    if harmonic % 2 = 1  // فردي
                        sample += (1.0 / harmonic) * sin(omega * harmonic * t)
                    else  // زوجي
                        sample -= (1.0 / harmonic) * sin(omega * harmonic * t)
                    ok
                next
            next
            
            sample = sample / (len(frequencies) * 2.0)
            wave[i + 1] = floor(sample * 25000)
        next
        
    elseif waveformType = "triangle"
        // موجة مثلثية
        for i = 0 to numSamples - 1
            t = i / sampleRate
            sample = 0
            
            for freq in frequencies
                // موجة مثلثية = sin(ωt) - 1/9 sin(3ωt) + 1/25 sin(5ωt) - ...
                for harmonic = 1 to 7 step 2
                    omega = 2 * 3.14159265359 * freq
                    sign = 1
                    if (harmonic - 1) % 4 = 2  // تغيير الإشارة
                        sign = -1
                    ok
                    sample += sign * (1.0 / (harmonic * harmonic)) * sin(omega * harmonic * t)
                next
            next
            
            sample = sample / (len(frequencies) * 1.2)
            wave[i + 1] = floor(sample * 26000)
        next
        
    else
        // موجة جيبية (الافتراضية)
        for i = 0 to numSamples - 1
            t = i / sampleRate
            sample = 0
            
            // جمع كل النوتات في الكورد
            for freq in frequencies
                sample += sin(2 * 3.14159265359 * freq * t)
            next
            
            // تطبيع السعة (القسمة على عدد النوتات)
            sample = sample / len(frequencies)
            
            // تحويل إلى 16-bit مع هامش أمان
            wave[i + 1] = floor(sample * 30000)
        next
    ok
    
    // تطبيق غلاف ADSR
    wave = applyADSR(wave, sampleRate)
    
    return wave
end

// ============= دالة تطبيق غلاف ADSR =============

func applyADSR(wave, sampleRate)
    numSamples = len(wave)
    
    // إعدادات الغلاف
    attackTime = 0.05  // 50ms هجوم
    decayTime = 0.1    // 100ms اضمحلال
    sustainLevel = 0.7 // مستوى الاستمرارية 70%
    releaseTime = 0.2  // 200ms تحرير
    
    attackSamples = floor(attackTime * sampleRate)
    decaySamples = floor(decayTime * sampleRate)
    releaseSamples = floor(releaseTime * sampleRate)
    
    // احتساب مرحلة الاستمرارية
    sustainSamples = numSamples - attackSamples - decaySamples - releaseSamples
    if sustainSamples < 0
        // إذا كانت المدة قصيرة، ضبط الأزمنة
        attackSamples = floor(numSamples * 0.1)
        decaySamples = floor(numSamples * 0.2)
        releaseSamples = floor(numSamples * 0.3)
        sustainSamples = numSamples - attackSamples - decaySamples - releaseSamples
    ok
    
    // تطبيق الغلاف
    for i = 1 to numSamples
        envelope = 1.0
        
        if i <= attackSamples
            // مرحلة الهجوم: من 0 إلى 1
            envelope = i / attackSamples
            
        elseif i <= attackSamples + decaySamples
            // مرحلة الاضمحلال: من 1 إلى sustainLevel
            decayPos = (i - attackSamples) / decaySamples
            envelope = 1.0 - (1.0 - sustainLevel) * decayPos
            
        elseif i <= attackSamples + decaySamples + sustainSamples
            // مرحلة الاستمرارية: ثابت
            envelope = sustainLevel
            
        else
            // مرحلة التحرير: من sustainLevel إلى 0
            releasePos = (i - (attackSamples + decaySamples + sustainSamples)) / releaseSamples
            if releasePos > 1 releasePos = 1 ok
            envelope = sustainLevel * (1.0 - releasePos)
        ok
        
        // تطبيق الغلاف على العينة
        wave[i] = floor(wave[i] * envelope)
    next
    
    return wave
end

// ============= دالة إنشاء كورد مع خيارات متقدمة =============

func createChordSound(frequencies, duration, sampleRate, options)
    /*
    options: جدول يحتوي على:
        - waveform: نوع الموجة
        - volume: مستوى الصوت (0-1)
        - fadeIn: مدة البداية التدريجية
        - fadeOut: مدة النهاية التدريجية
        - vibrato: اهتزاز الصوت
        - chorus: تأثير جوقة
    */
    
    // القيم الافتراضية
    waveform = getMap(options, "waveform", "sine")
    volume = getMap(options, "volume", 0.8)
    fadeIn = getMap(options, "fadeIn", 0.05)
    fadeOut = getMap(options, "fadeOut", 0.1)
    vibrato = getMap(options, "vibrato", false)
    chorus = getMap(options, "chorus", false)
    
    // توليد الموجة الأساسية
    wave = generateChordWave(frequencies, duration, sampleRate, waveform)
    
    // تطبيق مستوى الصوت
    if volume != 1.0
        for i = 1 to len(wave)
            wave[i] = floor(wave[i] * volume)
        next
    ok
    
    // تطبيق fade in/out إضافي
    numSamples = len(wave)
    fadeInSamples = floor(fadeIn * sampleRate)
    fadeOutSamples = floor(fadeOut * sampleRate)
    
    for i = 1 to numSamples
        fade = 1.0
        
        // Fade in
        if i <= fadeInSamples
            fade = i / fadeInSamples
        ok
        
        // Fade out
        if i > numSamples - fadeOutSamples
            fade = (numSamples - i) / fadeOutSamples
        ok
        
        wave[i] = floor(wave[i] * fade)
    next
    
    // تطبيق الـ vibrato إذا مطلوب
    if vibrato
        wave = applyVibrato(wave, sampleRate)
    ok
    
    // تطبيق الـ chorus إذا مطلوب
    if chorus
        wave = applyChorus(wave, sampleRate)
    ok
    
    return wave
end

// ============= دالة تطبيق vibrato =============

func applyVibrato(wave, sampleRate)
    numSamples = len(wave)
    vibratoRate = 5.0  // هرتز
    vibratoDepth = 0.02  // عمق الاهتزاز
    
    for i = 1 to numSamples
        t = i / sampleRate
        
        // تعديل بسيط في التردد
        vibrato = sin(2 * 3.14159 * vibratoRate * t) * vibratoDepth
        
        // تطبيق تأثير طفيف
        wave[i] = floor(wave[i] * (1.0 + vibrato * 0.3))
    next
    
    return wave
end

// ============= دالة تطبيق chorus =============

func applyChorus(wave, sampleRate)
    numSamples = len(wave)
    
    // إنشاء نسخة متأخرة قليلاً
    delaySamples = floor(0.03 * sampleRate)  // 30ms تأخير
    
    if delaySamples >= numSamples
        return wave
    ok
    
    // خلط الصوت الأصلي مع الصوت المتأخر
    result = list(numSamples)
    
    for i = 1 to numSamples
        // الصوت الأصلي (70%)
        original = wave[i] * 0.7
        
        // الصوت المتأخر (30%)
        delayed = 0
        if i > delaySamples
            delayed = wave[i - delaySamples] * 0.3
        ok
        
        result[i] = floor(original + delayed)
    next
    
    return result
end



// ============= أمثلة استخدام =============

func testGenerateChordWave()
    see "اختبار توليد كورادات مختلفة:" + nl
    see "==========================" + nl
    
    sampleRate = 44100
    duration = 1.0
    
    // كورد C Major
    cMajor = [261.63, 329.63, 392.00]
    
    see nl + "1. كورد C Major بموجة جيبية:" + nl
    wave1 = generateChordWave(cMajor, duration, sampleRate, "sine")
    see "   تم توليد " + string(len(wave1)) + " عينة" + nl
    
    see nl + "2. كورد C Major بموجة مربعة:" + nl
    wave2 = generateChordWave(cMajor, duration, sampleRate, "square")
    see "   تم توليد " + string(len(wave2)) + " عينة" + nl
    
    see nl + "3. كورد C Major بموجة سن المنشار:" + nl
    wave3 = generateChordWave(cMajor, duration, sampleRate, "saw")
    see "   تم توليد " + string(len(wave3)) + " عينة" + nl
    
    see nl + "4. كورد C Major بموجة مثلثية:" + nl
    wave4 = generateChordWave(cMajor, duration, sampleRate, "triangle")
    see "   تم توليد " + string(len(wave4)) + " عينة" + nl
    
    see nl + "5. كورد C Major مع خيارات متقدمة:" + nl
    options = [
        "waveform", "sine",
        "volume", 0.9,
        "fadeIn", 0.1,
        "fadeOut", 0.2,
        "vibrato", true,
        "chorus", true
    ]
    wave5 = createChordSound(cMajor, duration, sampleRate, options)
    see "   تم توليد " + string(len(wave5)) + " عينة" + nl
    
    return [wave1, wave2, wave3, wave4, wave5]
end

// ============= مثال عملي للكلمة "MUSIC" =============

func createMusicWord()
    see nl + "تحويل كلمة 'MUSIC' إلى كورادات:" + nl
    see "=================================" + nl
    
    sampleRate = 44100
    duration = 0.4
    silence = 0.1
    
    // كورادات الأحرف
    letters = [
        ["M", [220.00, 277.18, 329.63]],
        ["U", [349.23, 440.00, 523.25]],
        ["S", [369.99, 466.16, 554.37]],
        ["I", [261.63, 329.63, 392.00]],
        ["C", [261.63, 329.63, 392.00]]
    ]
    
    // جمع كل الموجات
    allSamples = []
    
    for letter in letters
        see "معالجة حرف " + letter[1] + "..." + nl
        wave = generateChordWave(letter[2], duration, sampleRate, "sine")
        
        for sample in wave
            allSamples + sample
        next
        
        // إضافة صمت
        silenceSamples = floor(silence * sampleRate)
        for i = 1 to silenceSamples
            allSamples + 0
        next
    next
    
    see nl + "تم توليد " + string(len(allSamples)) + " عينة إجمالاً" + nl
    return allSamples
end

// تشغيل الاختبارات
see "برنامج توليد كورادات موسيقية" + nl
see "===========================" + nl

// اختيار موجات مختلفة
testWaves = testGenerateChordWave()

// إنشاء كلمة كاملة
musicSamples = createMusicWord()

see nl + "انتهت عملية التوليد بنجاح!" + nl

func wordToMusic(word, outputFile)
    fp = fopen(outputFile, "wb")
    sampleRate = 44100
    letterDuration = 0.3  // ثانية لكل حرف
    silenceDuration = 0.1  // صمت بين الأحرف
    
    // جمع كل الموجات
    allSamples = []
    
    for i = 1 to len(word)
        asciiletter = Ascii(word[i])
        letter=word[i]
        if asciiletter >= Ascii('A') and asciiletter <= Ascii('Z') or asciiletter >= Ascii('a') and asciiletter <= Ascii('z')
            letter = upper(letter)
            see "معالجة الحرف: " + letter + nl
            
            // الحصول على الكورد الخاص بالحرف
            chordFreqs = getLetterChord(letter)
            see "  النوتات: "
            for freq in chordFreqs
                see string(freq) + "Hz "
            next
            see nl
            
            // توليد موجة الكورد
            wave = generateChordWave(chordFreqs, letterDuration, sampleRate,:sine)
            
            // إضافة الموجة
            for sample in wave
                allSamples + sample
            next
            
            // إضافة صمت بين الأحرف (ما عدا الأخير)
            if i < len(word)
                silenceSamples = floor(silenceDuration * sampleRate)
                for j = 1 to silenceSamples
                    allSamples + 0
                next
            ok
        ok
    next
    
    // كتابة ملف WAV
    writeWavFile(fp, allSamples, sampleRate)
    fclose(fp)
    
    return len(word)
end
// ============= دالة كتابة WAV =============

func wav2Flie(outputFile,allSamples,sampleRate)

 fp = fopen(outputFile, "wb")
    writeWavFile(fp, allSamples, sampleRate)
    fclose(fp)
    
end
    
func writeWavFile(fp, samples, sampleRate)
    dataSize = len(samples) * 2
    fileSize = dataSize + 36
    
    // Header
    fwrite(fp, "RIFF")
    fwrite(fp, char(fileSize & 0xFF))
    fwrite(fp, char((fileSize >> 8) & 0xFF))
    fwrite(fp, char((fileSize >> 16) & 0xFF))
    fwrite(fp, char((fileSize >> 24) & 0xFF))
    fwrite(fp, "WAVEfmt ")
    fwrite(fp, char(16))
    fwrite(fp, char(0))  fwrite(fp, char(0))  fwrite(fp, char(0))
    fwrite(fp, char(1))  fwrite(fp, char(0))
    fwrite(fp, char(1))  fwrite(fp, char(0))
    fwrite(fp, char(0x44))  fwrite(fp, char(0xAC))
    fwrite(fp, char(0))  fwrite(fp, char(0))
    fwrite(fp, char(0x88))  fwrite(fp, char(0x58))
    fwrite(fp, char(0x01))  fwrite(fp, char(0))
    fwrite(fp, char(2))  fwrite(fp, char(0))
    fwrite(fp, char(16))  fwrite(fp, char(0))
    fwrite(fp, "data")
    fwrite(fp, char(dataSize & 0xFF))
    fwrite(fp, char((dataSize >> 8) & 0xFF))
    fwrite(fp, char((dataSize >> 16) & 0xFF))
    fwrite(fp, char((dataSize >> 24) & 0xFF))
    
    // Data
    for sample in samples
        // قص القيم المتطرفة
        if sample > 32767 sample = 32767 ok
        if sample < -32768 sample = -32768 ok
        
        s = sample & 0xFFFF
        fwrite(fp, char(s & 0xFF))
        fwrite(fp, char((s >> 8) & 0xFF))
    next
end

func CreateNoteInfoFile(notes)
    fp = fopen("notes_info.txt", "w")
    
    fwrite(fp, "معلومات النوتات الموسيقية" + nl)
    fwrite(fp, "==========================" + nl + nl)
    
    for note in notes
        fwrite(fp, "النوتة: " + note + nl)
        fwrite(fp, "التردد: " + string(Piano[note]) + " هرتز" + nl)
        
        // حساب الأوكتاف
        if note = "c1"
            fwrite(fp, "الأوكتاف: الأول" + nl)
        ok
        if note = "c3"
            fwrite(fp, "الأوكتاف: الثالث" + nl)
        ok
        if note = "a1"
            fwrite(fp, "الأوكتاف: الأول" + nl)
        ok
        
        fwrite(fp, "-------------------" + nl)
    next
    
    fwrite(fp, nl + "معلومات تقنية:" + nl)
    fwrite(fp, "معدل العينات: 44100 هرتز" + nl)
    fwrite(fp, "الدقة: 16-bit" + nl)
    fwrite(fp, "القنوات: Mono (أحادي)" + nl)
    fwrite(fp, "مدة كل نوتة: 0.8 ثانية" + nl)
    fwrite(fp, "صمت بين النوتات: 20 مللي ثانية" + nl)
    
    fclose(fp)
    see "تم إنشاء ملف معلومات النوتات: notes_info.txt" + nl
end

