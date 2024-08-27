Title: Directory Backup Script

Description:

This Bash script automates the process of creating compressed backups of a specified directory. It includes an optional feature to remove old backups based on a time threshold.

Usage:

Modify the variables:

Replace /path/to/backup and /path/to/source with the actual paths to your backup and source directories.
Run the script:


bash file-backup.sh


Options:

(None)

License:

(Specify the license under which you distribute the script, e.g., MIT, GPL)

Author:

GitHUB-user: ziyad-tarek1
Linkedin: https://www.linkedin.com/in/ziyad-tarek-61a38818b/

Contact:

ziyadtarek180@gmail.com


Additional Notes:

The script creates backups in a timestamped .tar.gz format.
The optional backup removal feature removes backups older than 30 days.
For more advanced backup strategies, consider using tools like rsync or duplicity.
