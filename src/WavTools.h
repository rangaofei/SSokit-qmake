//
// Created by 冉高飞 on 2018/5/1.
//

#ifndef RESAMPLEDEMO_WAVTOOLS_H
#define RESAMPLEDEMO_WAVTOOLS_H

#include <iostream>
#include <fstream>

#define STATE_SUCCESS 0
#define STATE_ERR_NOT_WAV 1

const char RIFF[] = "RIFF";
const char WAVE[] = "WAVE";
const char FMT[] = "fmt ";
const char DATA[] = "data";

struct FmtChunk {
    char fmt[4];
    uint32_t chunk_size;
    uint16_t audio_format;
    uint16_t num_channels;
    uint32_t sample_rate;
    uint32_t byte_rate;
    uint16_t block_align;
    uint16_t bit_per_sample;
};

struct DataChunk {
    char data[4];
    uint32_t chunk_size;
};
struct WavHeader {
    char riff[4];
    uint32_t chunk_size;
    char format[4];
    FmtChunk fmtChunk;
    DataChunk dataChunk;
};

class WavTools {
public:
    WavTools();

    ~WavTools();

    WavHeader *getWaveHeader();

    WavHeader *getInfoFromFIle(FILE *file);

    int getWavFormat(std::ifstream *in_stream, FmtChunk *fmtChunk);

    void getInfoFromStream(WavHeader *wavHeader, std::ifstream *instream);

    int writeWavInfoToFile(std::ofstream *outstream, WavHeader *header);

    int seekToRealData(std::ifstream *in_stream);

private:
    WavHeader *wavHeader;
    uint32_t chunk_size;
};


#endif //RESAMPLEDEMO_WAVTOOLS_H
