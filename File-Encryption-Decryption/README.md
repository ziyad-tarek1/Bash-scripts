# File Encryption and Decryption Tool
=====================================

This is a simple file encryption and decryption tool that allows you to encrypt and decrypt files using various methods.

## Getting Started
---------------

To use this tool, follow these steps:

1. Clone the repository: `git clone https://github.com/ziyad-tarek1/File-Encryption-Decryption`
2. Navigate to the cloned repository: `cd File-Encryption-Decryption`
3. Make the scripts executable: `chmod +x encrypt.sh decrypt.sh`

## Usage
-----

### Encrypting a File

To encrypt a file, run `./encrypt.sh` and follow the prompts.

1. Choose an encryption method:
	* AES-256-CBC
	* AES-128-CBC
	* DES3
	* Base64
2. Enter the file path: `/path/to/file.txt`
3. The encrypted file will be saved with a `.enc` or `.b64` extension, depending on the chosen method.

### Decrypting a File

To decrypt a file, run `./decrypt.sh` and follow the prompts.

1. Choose a decryption method:
	* AES-256-CBC
	* AES-128-CBC
	* DES3
	* Base64
2. Enter the file path: `/path/to/file.enc` or `/path/to/file.b64`
3. The decrypted file will be saved with the original file name.

## Methods
-------

The following encryption methods are supported:

* AES-256-CBC: A symmetric key block cipher with a 256-bit key and CBC mode.
* AES-128-CBC: A symmetric key block cipher with a 128-bit key and CBC mode.
* DES3: A symmetric key block cipher with a 168-bit key and CBC mode.
* Base64: A encoding scheme that represents binary data as a string of ASCII characters.

## Notes
-----

* This tool uses the `openssl` command to perform encryption and decryption operations.
* The password is currently hardcoded in the `functions.sh` file, but in a real-world scenario, you should use a more secure method to store and retrieve the password.
* This tool is for educational purposes only and should not be used for sensitive or confidential data.

I hope this helps! Let me know if you have any questions or need further assistance.
