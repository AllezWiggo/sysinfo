# sysinfo

Linux utility to capture resource usage statistics periodically during performance testing.

## Usage
If you pulled and configured the utility in folder:
```
/home/centos/sysinfo
```
Then you can configure the cron job as below.
```
sudo crontab -e
*/1 * * * * /home/centos/sysinfo/stats.sh
```
This will execute the scripts and collect statistics every 1 minute.
Feel free to change the duration as per your need.

## Configurations
The configurations for the tests can be found in test.cfg file.

### HOME_DIR
Location of sysinfo folder. 

E.g. `/home/centos/sysinfo`

### DATA_DIR
Location where the utility will create a folder with TEST_NAME and store all generated files.

E.g. `/home/centos/sysinfo/data`

### TEST_NAME
Name of the current test being run.

### TEST_ENV
It can be any of the values below.

AWS - The utility will get instance type using ec3 url.

Local - Will set instance type as n/a.


## Compatibility
 - [x] Centos
