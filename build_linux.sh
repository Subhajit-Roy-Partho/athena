#!/bin/bash

# This script is the Linux equivalent for the provided Windows build batch file.
# It builds the Athena application using PyInstaller.

# Check if the version file exists, and if not, run the preflight script.
if [ ! -f "athena_version.py" ]; then
    echo "Warning: didn't find athena_version.py, so running build_preflight.py first"
    # Using python3 is recommended on modern Linux systems
    python3 ./build_preflight.py
fi

# Run PyInstaller with Linux-specific syntax.
# Note the changes:
# - Path separators are '/' instead of '\'.
# - The separator for --add-data and --add-binary is ':' instead of ';'.
# - Line continuation is '\' instead of '^'.
# - Environment variables are '$VAR' instead of '%VAR%'.
# - All script arguments are passed with '"$@"'.
pyinstaller ./src/main.py --add-data "ui:ui" --add-data "tools:tools" --add-data "sample_inputs:sample_inputs" \
                          --add-data "src/qml:qml" --add-data "src/shaders:shaders"  --add-data "src/txt:txt" \
                          --add-data "athena_version.py:version.py" \
                          --add-binary "$VIRTUAL_ENV/lib/site-packages/PySide2/plugins/geometryloaders:qt5_plugins/geometryloaders" \
                          --version-file version_info.txt --name Athena --icon icon/athena.ico "$@"
