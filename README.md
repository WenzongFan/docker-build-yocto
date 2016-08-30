# docker-build-yocto

This is a test case for reproducing yocto build issue about:

pseudo 1.8.1 + docker & dumb-init

The docker container will be terminated in the middle of build with error:

```
Child process timeout after 2 seconds.
Child process exit status 4: lock_held
```

After checking with `git bisect`, the bad commit was narrowed down to:

```
commit 77ee254a6c974aad9bcab2c58c9ee9e0880c9718
Author: Peter Seebach <peter.seebach@windriver.com>
Date:   Tue Mar 1 16:21:15 2016 -0600

    Server launch reworking.
    
    This is the big overhaul to have the server provide meaningful exit status
    to clients.
    
    In the process, I discovered that the server was running with signals blocked
    if launched by a client, which is not a good thing, and prevented this from
    working as intended.
    
    Still looking to see why more than one server spawn seems to happen.

```

The build works after revert this commit (only kept the changes for enums/exit_status.in)

## Start testing

* Make sure docker is installed, install guide refer to <https://docs.docker.com/engine/installation/linux/>

* Generate a ubuntu16.04 image that with dumb-init as init system:

	$ mk-docker-image.sh

* Start to build poky with the image:

	$ start-poky-build.sh

## See also

* [dumb-init](https://github.com/Yelp/dumb-init): A minimal init system for Linux containers
