# bav-browser

## Interaction via the Web

Please visit ***#TODO: GitHub pages link*** to interact with a fully-installed version of the bav-browser.

## Installing a Local Copy of the Database

The following instructions are adapted from the [JBrowse2 Lab Setup Guide](https://github.com/bioe131/lab_8_fa24/blob/main/README.md) for BioE 131 at UC Berkeley Fall 2024-25. This adaptation is <ins>primarily for MacOS users</ins>, so please reference the aforementioned setup guide if you are installing a local copy of the database on Windows or Linux systems.

### 1. Homebrew Installation

Open a terminal and run the line below to install homebrew, a macOS package manager. This will make it easy for you to install necessary packages like apache2 and samtools. _You can skip this step if you already have brew installed._

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
If this doesn't work, visit https://docs.brew.sh/Installation for further installation options, including a .pkg installer that should be convenient and easy to use.

### 2. Install Dependencies

#### 2.1. Node.js

Node.js is a cross-platform JavaScript runtime environment that will make is easy to run JBrowse2 command-line tools.

First, check whether Node.js is already installed by running the following. If node v20 is already installed, you can skip to the next step.

```
node -v
```

If Node.js is not installed, install it.

On macOS, you can use brew. You may need to restart the terminal (close and open a new one) to get `node -v` to run.

```
# NOTE:
# Homebrew is not a Node.js package manager.
# Please ensure it is already installed on your system.
# Follow official instructions at https://brew.sh/
# Homebrew only supports installing major Node.js versions and might not support the latest Node.js version from the 20 release line.
# download and install Node.js
brew install node@20
# verifies the right Node.js version is in the environment
node -v # should print `v20.18.0`
# verifies the right npm version is in the environment
npm -v # should print `10.8.2`
```

#### 2.2. @jbrowse/cli

Run the following commands in your shell. This uses the Node.js package manager to download the latest stable version of the jbrowse command line tool, then prints out its version. This should work for both macOS and Linux.

```
sudo npm install -g @jbrowse/cli
jbrowse --version
```

You can also try installing using just `npm install -g @jbrowse/cli` if the sudo version doesn't run. 

#### 2.3. Other System Dependencies

Install wget (if not already installed), apache2, samtools, and tabix. wget is a tool for retrieving files over widely-used Internet protocols like HTTP and FTP. apache2 allows you to run a web server on your machine. samtools and tabix are tools for processing and indexing genome and genome annotation files. seqkit<sup>1</sup> is a helpful utility for processing fasta files.

```
# note that apache2 gets installed as httpd for macOS, which is the service you will launch later
brew install wget httpd samtools htslib seqkit
```

#### 2.4 NCBI Executables

Install a datasets, a helpful NCBI utility for interacting with their databases. The following MacOS instructions are summarized from [here](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/). For installation on Linux/Windows systems, please consult the aforementioned link.

```bash
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/mac/datasets'
chmod +x datasets # you may need to run `sudo chmod +x datasets`
```

### 3. Web Server + JBrowse Setup

#### 3.1 apache2 Server Setup

Finally, it's time to get the local JBrowse instance up and running! To start the web server, run this command: 

```bash
sudo brew services start httpd
```

#### 3.2 Verify apache2 Server Folder

For MacOS installations using brew, the apache server folder will likely be in `/opt/homebrew/var/www` (for M1) or `/usr/local/var/www` (for Intel). You can run `brew --prefix` to get the brew install location, and then from there it is in the `var/www` folder. Take note of what the folder is, and use the command below to store it as a command-line variable. We can reference this variable in the rest of our code, to save on typing. You will need to re-run the export if you restart your terminal session!

```bash
# be sure to replace the path with your actual true path!
export APACHE_ROOT='/path/to/rootdir'
```

For local hosting, the url to your running web server will be http://localhost:8080/. If you open a browser window to this URL, you should now see the message "It works!".

#### 3.3 JBrowse Initialization

To initialize the JBrowse file system (where we'll store our genomes, annotations, etc. for the browser), run the following command:

```bash
chmod +x scripts/jbrowse_init.sh # you may need to run `sudo chmod +x scripts/jbrowse_init.sh`
./scripts/jbrowse_init.sh
```

### 4. Datasets + Bioinformatics Work

Follow the command line instructions found at ***#TODO: add link to datasets markdown file in github***

### 5. You're Done!

With your local copy of the bav-browser database fully set up, it's time to interact with the JBrowse2 genome browser! Documentation for some of the amazing things that JBrowse2 can do can be found [here](https://jbrowse.org/jb2/docs/). Good luck, and happy browsing!

When you are done with your local copy of the bav-browser, run the following commands to clean up your file system and shut down the apache2 web server:

```bash
chmod +x scripts/jbrowse_cleanup.sh # you may need to run `sudo chmod +x scripts/jbrowse_cleanup.sh`
./scripts/jbrowse_cleanup.sh
sudo brew services stop httpd
```

### Citations (Computational Tools)

1. Wei Shen*, Botond Sipos, and Liuyang Zhao. 2024. SeqKit2: A Swiss Army Knife for Sequence and Alignment Processing. iMeta e191. doi:10.1002/imt2.191

***#TODO: get citations for whatever we can tool-wise***