set shell := ["nu", "-c"]

default:
    @just --list

# start dev server
dev:
    source script.nu;dev_command

# end dev server
dev_finish:
    source script.nu;dev_finish_command

# build pdf
build:
    sass style/index.scss style.css
    vivliostyle build --config vivliostyle.config.js --style style.css --executable-browser "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"

# view demo
preview_demo:
    vivliostyle preview demo.md --theme @vivliostyle/theme-techbook --style style.css --executable-browser "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"

# build demo
build_demo:
    vivliostyle build demo.md --output demo.pdf --style style.css --executable-browser "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"