set shell := ["nu", "-c"]

dev_pueue_group_name := "vivliostyle_template"
dev_pueue_temp_file_path := ".temp_pueue_ids"
export VIVLIOSTYLE_BROUSER_PATH := '"C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"'

default:
    @just --list -u

# start dev server
dev:
    source script.nu; dev_command {{dev_pueue_group_name}} {{dev_pueue_temp_file_path}}

# end dev server
dev_finish:
    source script.nu; dev_finish_command {{dev_pueue_group_name}} {{dev_pueue_temp_file_path}}

# build pdf
build:
    sass style/index.scss style.css
    vivliostyle build --config vivliostyle.config.js --style style.css --executable-browser {{VIVLIOSTYLE_BROUSER_PATH}}

# view demo
preview_demo:
    vivliostyle preview demo.md --theme @vivliostyle/theme-techbook --style style.css --executable-browser {{VIVLIOSTYLE_BROUSER_PATH}}

# build demo
build_demo:
    vivliostyle build demo.md --output demo.pdf --style style.css --executable-browser {{VIVLIOSTYLE_BROUSER_PATH}}