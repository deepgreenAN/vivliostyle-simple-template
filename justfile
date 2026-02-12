set shell := ["nu", "-c"]

default:
    @just --list -u

# start dev server
dev:
    source script.nu;wait --any { ^vivliostyle preview --config vivliostyle.config.js --style style.css o+e>| each { |$line| print --no-newline $"($line)"}} { ^sass style/index.scss style.css -w o+e>| each { |$line| print --no-newline $"(ansi yellow)($line)(ansi reset)"} }

# build pdf
build:
    sass style/index.scss style.css
    vivliostyle build --config vivliostyle.config.js --style style.css
