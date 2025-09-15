compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# Transcode a video to a good-balance 1080p that's great for sharing online
transcode-video-1080p() {
  ffmpeg -i $1 -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy ${1%.*}-1080p.mp4
}

# Transcode a video to a good-balance 4K that's great for sharing online
transcode-video-4K() {
  ffmpeg -i $1 -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k ${1%.*}-optimized.mp4
}

# Transcode any image to JPG image that's great for shrinking wallpapers
img2jpg() {
  magick $1 -quality 95 -strip ${1%.*}.jpg
}

# Transcode any image to JPG image that's great for sharing online without being too big
img2jpg-small() {
  magick $1 -resize 1080x\> -quality 95 -strip ${1%.*}.jpg
}

# Transcode any image to compressed-but-lossless PNG
img2png() {
  magick "$1" -strip -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${1%.*}.png"
}

# Get the url for the rss feed of a YouTube channel
ytrss() {
    [[ -z $1 ]] && echo "Usage: ytrss YOUTUBE_CHANNEL_URL" && return 0
    curl -s ${1} | grep -oE "https://www\.youtube\.com/feeds/videos\.xml\?channel_id=\S{24}" | head -n 1
}

# Escape question mark character in pasted links
# Prevents errros when pasting YouTube links for ytrss and mpv
set zle_bracketed_paste
autoload -Uz bracketed-paste-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic

r() {
    if [[ "$1" != "new" ]]; then
        bin/rails "$@" && return 0
        return 1
    fi

    [[ -z "$2" ]] && echo "Usage: rails new <app_name>" && return 1
    rails new "$2" --css=tailwind
    sed -i '/group :development do/ a\  gem "hotwire-spark"' "$2/Gemfile"
    cd "$2" && bundle install
}
