Effective Mobile Tech Task

This will up a docker container with simple golang http server, which will have 2 random responses,
first is 200 http.StatusOK, second is 500 http.StatusInternalServerError.

```
make infra
```

##

This will setup automatically the systemd, compy file content, make files executable and run it all.

```
make run
```

##

If process-monitor.service will be restarted, it will log out that it is started on new PID.
