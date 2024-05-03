#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 [venv_path] [requirements_url]"
    exit 1
fi

venvpath="$1"
requirements_url="$2"

if [ ! -d "$venvpath/bin" ]; then
    echo "Creating Python virtual environment at $venvpath"
    python3 -m venv "$venvpath"
else
    echo "Virtual environment already exists at $venvpath"
fi

if [ ! -f "$venvpath/requirements.txt" ]; then
    echo "Creating empty requirements.txt"
    touch "$venvpath/requirements.txt"
fi

echo "Fetching requirements from specified URL..."
curl -s "$requirements_url" > "$venvpath/new_requirements.txt"

echo "Checking for updates in requirements..."
if ! cmp -s "$venvpath/requirements.txt" "$venvpath/new_requirements.txt"; then
    echo "Differences found, updating requirements.txt..."
    mv "$venvpath/new_requirements.txt" "$venvpath/requirements.txt"
    updated=true
else
    echo "No update needed."
    updated=false
    rm "$venvpath/new_requirements.txt"
fi

if [ "$updated" = true ]; then
    echo "Installing updated requirements..."
    "$venvpath/bin/pip" install -r "$venvpath/requirements.txt"
fi

echo "Script completed successfully. Please activate your virtual environment manually to use it."
