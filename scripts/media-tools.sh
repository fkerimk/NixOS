#!/usr/bin/env bash

while getopts "i:o:m:" opt; do
    case ${opt} in
        i) input="$OPTARG" ;;
        o) output="$OPTARG" ;;
        m) mode="$OPTARG";;
        h)
            exit 1 ;;
        \?) exit 1 ;;
        :) exit 1 ;;
    esac
done

if [[ -z "$mode" ]]; then exit 1; fi
if [[ -z "$input" ]]; then exit 1; fi

case "$mode" in
    "davinci")
        output="$input.mov"
        ffmpeg -i "$input" -c:v dnxhd -profile:v dnxhr_hq -c:a pcm_s16le -pix_fmt yuv422p "$output"
        ;;
esac


