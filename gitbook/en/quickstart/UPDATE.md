# Update

### When to update 
* Sometimes vps used as dns server or sskcp is in low performance or high latency, so you want to replace it to a new one or just add a new one.
* Sometimes network flow increases too large to handle by current sskcp server, so that you want to add more or vice versa.

### How to update
The most simple way to update configuration is using `update`, which will change the default `INFO` in power-client-[ARCH]/client and restart all services 
```bash
make update
``` 

**Note that `info` can also be provided to update, like below:**
```bash
make update INFO=/path/to/info
```

### Check status and configuration after updating
* Check whether configuration updated
```bash
make showconf
```

* Check status of running services 
```bash
make test_state
```
