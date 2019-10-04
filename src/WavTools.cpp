//
// Created by 冉高飞 on 2018/5/1.
//

#include "WavTools.h"


WavTools::WavTools() {

}

WavTools::~WavTools() {
//    delete wavHeader;
}

WavHeader *WavTools::getInfoFromFIle(FILE *file) {
    wavHeader = (WavHeader *) malloc(sizeof(wavHeader));
    if (file) {

    }
    return wavHeader;
}

void WavTools::getInfoFromStream(WavHeader *header, std::ifstream *instream) {
    if (instream->is_open()) {
        instream->seekg(0, std::ios::beg);
        instream->read((char *) header, sizeof(WavHeader));

        std::cout << "The header :"
                  << header->riff
                  << "\nchunk_size:"
                  << header->chunk_size << "\nformat:"
                  << header->format << std::endl;
        std::cout << "The fmtChunk :"
                  << header->fmtChunk.fmt
                  << "\nchunk_size:"
                  << header->fmtChunk.chunk_size
                  << "\nformat:"
                  << ((header->fmtChunk.audio_format) == 1 ? "PCM" : "OTHER")
                  << "\nnumber of channels:"
                  << header->fmtChunk.num_channels
                  << "\nsample_rate:"
                  << header->fmtChunk.sample_rate
                  << std::endl;

        std::cout << "The dataChunk:"
                  << header->dataChunk.data
                  << "\nchunk_size:"
                  << header->dataChunk.chunk_size
                  << std::endl;
    } else {
        std::cout << "there is no file" << std::endl;
    }
}

int WavTools::writeWavInfoToFile(std::ofstream *outstream, WavHeader *header) {
    if (!outstream->is_open()) {
        std::cout << "the stream is null" << std::endl;
        return -1;
    }
    header->fmtChunk.byte_rate =
            header->fmtChunk.sample_rate * header->fmtChunk.num_channels * header->fmtChunk.bit_per_sample / 8;
    outstream->write((char *) header, sizeof(WavHeader));
    return 0;
}

int WavTools::getWavFormat(std::ifstream *in_stream, FmtChunk *fmtChunk) {
    if (!in_stream->is_open()) {
        std::cout << "the stream is null" << std::endl;
        return -1;
    }
    in_stream->seekg(0, std::ios::beg);
    char tmp_header[5];
    memset(tmp_header, 0, 5 * sizeof(char));
    in_stream->read(tmp_header, 4);
    if (strcmp(tmp_header, RIFF) != 0) {
        std::cout << "tmp_header:" << tmp_header << std::endl;
        return STATE_ERR_NOT_WAV;
    }
    in_stream->seekg(8, std::ios::cur);
    while (true) {
        in_stream->read(tmp_header, 4);
        if (strcmp(tmp_header, FMT) != 0) {
            in_stream->read((char *) &chunk_size, sizeof(uint32_t));
            in_stream->seekg(chunk_size, std::ios::cur);
            continue;
        } else {
            in_stream->seekg(-4, std::ios::cur);
            in_stream->read((char *) fmtChunk, sizeof(FmtChunk));
            std::cout << "The fmtChunk :"
                      << fmtChunk->fmt
                      << "\nchunk_size:"
                      << fmtChunk->chunk_size
                      << "\nformat:"
                      << ((fmtChunk->audio_format) == 1 ? "PCM" : "OTHER")
                      << "\nnumber of channels:"
                      << fmtChunk->num_channels
                      << "\nsample_rate:"
                      << fmtChunk->sample_rate
                      << "\nbyte_rate:"
                      << fmtChunk->byte_rate
                      << "\nblock_align:"
                      << fmtChunk->block_align
                      << "\nbit_per_sample:"
                      << fmtChunk->bit_per_sample
                      << std::endl;
            break;
        }

    }
    return STATE_SUCCESS;
}

int WavTools::seekToRealData(std::ifstream *in_stream) {
    if (!(in_stream->is_open())) {
        std::cout << "the stream is null" << std::endl;
        return -1;
    }
    in_stream->seekg(0, std::ios::beg);
    char tmp_header[5];
    memset(tmp_header, 0, 5 * sizeof(char));
    in_stream->read(tmp_header, 4);
    if (strcmp(tmp_header, RIFF) != 0) {
        std::cout << "tmp_header:" << tmp_header << std::endl;
        return STATE_ERR_NOT_WAV;
    }
    in_stream->seekg(8, std::ios::cur);
    while (true) {
        in_stream->read(tmp_header, 4);
        if (strcmp(tmp_header, DATA) != 0) {
            in_stream->read((char *) &chunk_size, sizeof(uint32_t));
            in_stream->seekg(chunk_size, std::ios::cur);
            continue;
        } else {
            auto *dataChunk = static_cast<DataChunk *>(malloc(sizeof(DataChunk)));
            in_stream->seekg(-4, std::ios::cur);
            in_stream->read((char *) dataChunk, sizeof(DataChunk));
            std::cout << "data chunk:\n"
                      << "name:"
                      << dataChunk->data
                      << "\nchunk_size:"
                      << dataChunk->chunk_size
                      << std::endl;
            break;
        }

    }
    return STATE_SUCCESS;
}

