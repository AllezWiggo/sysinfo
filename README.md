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

## Compatibility
 - [x] Centos
