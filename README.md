# sysinfo

Linux utility to capture resource usage statistics periodically during performance testing.

## Usage
If you pulled and configured the utility in folder:
```
/home/centos/sysinfo
```
Then you can configure the cron job as below.

The script takes one argument:
 * Location of sysinfo folder

```
sudo crontab -e
*/1 * * * * /home/centos/sysinfo/stats.sh "/home/centos/sysinfo"
```
This will execute the scripts and collect statistics every 1 minute.
Feel free to change the duration as per your need.

If you do not pass the mandatory argument, you will see the message below.
```
Usage: ./stats.sh <base folder location>
```

## Configurations

The configurations for the tests can be found in `test.cfg` file.

### DATA_DIR
Location where the utility will create a folder with TEST_NAME and store all generated files.

E.g. `/home/centos/sysinfo/data`

### TEST_NAME
Name of the current test being run.

### TEST_ENV
It can be any of the values below.

AWS - The utility will get instance type using ec2 metadata url.

Local - Will set instance type as n/a.


## Compatibility
 - [x] Centos
