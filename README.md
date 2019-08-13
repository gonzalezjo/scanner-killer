# Revisiting Zip Bombs

Several AV scanners are vulnerable to an attack that can lead to scanner denial of service. A tarball must be created to maximize file density. To do so, a text file containing the words "hello" (anything under 512 bytes should suffice) and was tarred with format=gnu. The format is not particularly important. All but the first 1024 bytes were removed, so as to increase tar file density. All bytes after the first 1024 are unnecessary padding.


Tar files, in their essence, are linked lists. Tar files can be concatenated together thousands of times to contain thousands of files. In this case, a ten-megabyte file and a one-hundred-megabyte file were created by repeatedly concatenating the initial tar file together. Traversing this file is a slow process.


Simply gzipping the result creates a file that takes up an enormous amount of scanner resources  while consuming relatively few bytes. On its own, this is not enormously severe. However, the produced tar files serve as a building block for an escalation of the attack vector. If an attacker creates a folder in a frequently scanned directory (say, for instance, creating the folder C:\1A on a system that receives full scans often.,) with thousands of these files, each subtly different, the system becomes practically unscannable.


## Resources:
1) archive_nonull: A tar file with all optional padding removed.


2) generate_tar_file.sh: compresses a file with format=gnu.


3) maketar.lua: Takes archive_nonull and produces an output file with a preconfigured amount of files in it. 


4) The .tar.gz files are payloads of various sizes. Proceed with caution in downloading them.

## Impact

Complete scanner denial of service. The system may be rendered completely unscannable. As a result, a vast amount of Kaspersky's security features are defeated.
