set shell := ["nu", "-c"]

# sass dev server
dev:
    watch style {|| sass style/index.scss style.css}

# viewer start
preview:
    vivliostyle preview --config vivliostyle.config.js --style style.css --executable-browser "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"

# build pdf
build:
    vivliostyle build --config vivliostyle.config.js --style style.css --executable-browser "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"

# view demo
demo:
    vivliostyle preview demo.md --theme @vivliostyle/theme-techbook --style style.css --executable-browser "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"