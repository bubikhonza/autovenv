# autovenv

## Overview
This simple tool uses `virtualenv` in background and manages the dependencies from requirements file located at a given URL. It ensures that the latest dependencies are fetched and installed only if there are changes detected between the local and remote requirements.

## Features
- **Environment Setup**: Creates a Python virtual environment using venv.
- **Dependency Management**: Checks for updates of requirements from a specified URL (tested on github) and updates if necessary.

## Prerequisites

- Python with venv library (https://docs.python.org/3/library/venv.html)

## How to Use
    ```cmd
    autovenv.bat <path_to_venv> <requirements_url>
    ```
    ```bash
    ./autovenv.sh <path_to_venv> <requirements_url>
    ```

    Example:
    ```cmd
    autovenv.bat myenv https://raw.githubusercontent.com/uber/Python-Sample-Application/master/requirements-test.txt
    ```
    ```bash
    ./autovenv.sh myenv https://raw.githubusercontent.com/uber/Python-Sample-Application/master/requirements-test.txt
    ```

After running the script, you must manually activate the virtual environment.

If you need to force update the dependencies, delete the `requirements.snapshot.txt` file located at: `<path_to_venv>\requirements.snapshot.txt` and rerun.

