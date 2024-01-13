#!/bin/bash

# This script packages the code into a zip file compatible with 
# the AWS Lambda runtime. It automates the process of preparing
# a deployment package by installing production dependencies,
# copying necessary files, and creating a zip file for Lambda.


# Function to print help message
print_help() {
  echo "Usage: $0 -p <package_manager> -d <directory> [-t <temp_directory>] [-o <output_directory>] [-h]"
  echo "Options:"
  echo "  -p <package_manager>        Specify the package manager (yarn | npm)."
  echo "  -d <directory>              Specify the directory where .js files exist."
  echo "  -t <temp_directory>         Specify the temporary directory (default: .temp)."
  echo "  -o <output_directory>       Specify the output path (relative to the script's directory)."
  echo "  -h                          Print this help message."
}

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to cleanup and delete temp directory
cleanup() {
  if [ -d "$temp_directory" ]; then
    echo "Cleaning up. Deleting temp directory '$temp_directory'."
    rm -rf "$temp_directory"
  fi
}

# Trap exit signals to ensure cleanup is performed
trap cleanup EXIT

# Set default values
temp_directory=".temp"
output_directory="deployable"

# Parse command line options
while getopts ":p:d:t:o:h" opt; do
  case $opt in
    p)
      package_manager="$OPTARG"
      ;;
    d)
      directory="$OPTARG"
      ;;
    t)
      temp_directory="$OPTARG"
      ;;
    o)
      output_directory="$OPTARG"
      ;;
    h)
      print_help
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      print_help
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      print_help
      exit 1
      ;;
  esac
done

# Check if 'package.json' exists in the current directory
if [ ! -f "package.json" ]; then
  echo "Error: 'package.json' not found in the current directory."
  exit 1
fi

# Check if help option is provided
if [ -z "$package_manager" ] || [ -z "$directory" ]; then
  echo "Error: Missing required options."
  print_help
  exit 1
fi

# Check if the package manager exists
if [ "$package_manager" != "yarn" ] && [ "$package_manager" != "npm" ]; then
  echo "Error: Invalid package manager. Use 'yarn' or 'npm'."
  print_help
  exit 1
fi

# Check if the package manager command exists
if command_exists "$package_manager"; then
  echo "Package manager '$package_manager' found."
else
  echo "Error: Package manager '$package_manager' not found."
  exit 1
fi

# Check if the directory exists
if [ -d "$directory" ]; then
  echo "Directory '$directory' found."
else
  echo "Error: Directory '$directory' not found."
  exit 1
fi

# Check if the temp directory exists, delete and create a new one
if [ -d "$temp_directory" ]; then
  echo "Deleting existing temp directory '$temp_directory'."
  rm -rf "$temp_directory"
fi

# Check if the output directory exists, delete and then create a new one
if [ -d "$output_directory" ]; then
  echo "Deleting existing output directory '$output_directory'."
  rm -rf "$output_directory"
fi

# If all checks pass, you can proceed with the rest of your script here
echo "All checks passed. Continue with the script logic."

echo "Creating temp directory '$temp_directory'."
mkdir -p "$temp_directory"

# Copy contents of the specified directory into the temp directory
echo "Copying contents of '$directory' into '$temp_directory'."
cp -r "$directory"/* "$temp_directory"
cp package.json "$temp_directory"

# Install only production dependencies using the specified package manager
echo "Installing production dependencies using '$package_manager' in '$temp_directory'."
if [ "$package_manager" == "yarn" ]; then
  # If 'yarn.lock' exists then copy it to the temp directory
  if [ -f "yarn.lock" ]; then
    echo "Copying 'yarn.lock' file to $temp_directory"
    cp yarn.lock "$temp_directory"
  fi
  yarn install --cwd "$temp_directory" --production
  # yarn install --modules-folder "$temp_directory/node_modules" --production
elif [ "$package_manager" == "npm" ]; then
  # If 'package-lock.json' exists then copy it to the temp directory
  if [ -f "package-lock.json" ]; then
    echo "Copying 'package-lock.json' file to $temp_directory"
    cp package-lock.json "$temp_directory"
  fi
  npm install --prefix "$temp_directory" --omit=dev
fi

# Check if the output directory exists, create if not
if [ ! -d "$output_directory" ]; then
  mkdir -p "$output_directory"
fi

# Create a zip file of the content of the temporary directory
cd $temp_directory
zip -r "../$output_directory/lambda.zip" .
cd ..

echo "Lambda deployment package created and stored at '$output_directory/lambda.zip'."
