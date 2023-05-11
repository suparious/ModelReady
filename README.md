# ModelReady: A Comprehensive Suite for Data Scientists

The Data Science Toolkit is a versatile collection of tools designed for managing data science processes, including model conversion, training, deployment, and integration into various applications. This toolkit aims to streamline the management of AI-related tasks and facilitate the adoption of data science tools in diverse scenarios.

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Features](#features)
   - [Installers](#installers)
   - [Launchers](#launchers)
   - [Systemd Services](#systemd-services)
   - [Converters](#converters)
   - [Prompts](#prompts)
   - [Training](#training)
5. [Usage](#usage)
6. [Contributing](#contributing)
7. [License](#license)

## Introduction

This project aims to provide a comprehensive suite of tools for managing data science processes, from model conversion and training to deploying AI applications. The toolkit is designed to work seamlessly with various machine learning frameworks and libraries.

## Prerequisites

Before installing the Data Science Toolkit, ensure that you have the following installed:

- Python 3.x (pip, venv)
- python3-is-python (if you need to)
- CUDA 10.2+ (recommend 11+, but >12 seems broken for some libraries)
- nvcc   (usually comes with CUDA and is located in the CUDA_HOME/bin directory)

## Installation

To get started with the Data Science Toolkit, clone this repository and install the required dependencies:

```bash
git clone https://github.com/yourusername/data-science-toolkit.git
cd data-science-toolkit
pip install -r requirements.txt
```

## Quick Start

Refer to each feature's specific README for detailed instructions on how to use the provided scripts.

## Features

### Installers

Installers provide a set of scripts that automatically create virtual Python environments and set up all necessary dependencies for machine learning applications. These scripts simplify the installation process and ensure a consistent environment across projects.

### Launchers

The launchers are a set of scripts designed to initiate various data science applications. These launchers streamline the deployment process and provide an efficient way to manage AI-related tasks.

### Systemd Services

This part of the toolkit offers a collection of systemd services tailored for working on remote machines. These services facilitate the deployment and management of data science tools on remote servers, enabling seamless integration into existing infrastructure.

### Converters

This section contains a collection of scripts for converting between different model formats. These converters make it easy to work with various model formats and ensure compatibility with different machine learning libraries.

### Prompts

A collection of prompts is available to simplify the process of interacting with machine learning models. These prompts can be used as templates to generate custom text or to fine-tune models for specific use cases.

### Training

The training section includes a collection of scripts for training models. These scripts are designed to streamline the training process and make it easier to create and fine-tune custom machine learning models.

## Usage

The Data Science Toolkit is designed to help manage data science processes in various scenarios. Refer to each feature's specific README for detailed instructions on how to use the provided scripts.

## Contributing

Contributions to the Data Science Toolkit are welcome. Please follow the [contributing guidelines](CONTRIBUTING.md) to ensure a smooth collaboration process.

## License

This project is licensed under the [GNU License](LICENSE). Please see the [license file](LICENSE) for more information.
