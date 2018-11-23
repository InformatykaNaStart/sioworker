# sioworker

A configuration can be adjusted using following environment variables (the `-e 'variable=value'` switch of the `docker run` command):

* `FILETRACKER_URL` **(required)** - an URL pointing to the oioioi main node's filetracker
* `SIOWORKERSD_HOST` **(required)** - an IP address of the oioioi main node
* `PROBLEM_MEMORY_MAX_LIMIT` **(required)** - memory limit for a single problem in kB
* `WORKER_CONCURRENCY` **(required)** - maximum number of tasks judged in parallel
* `CACHE_SIZE` (default `10G`) - max size of a local cache (cache is used to store problems input and output data)
* `SCAN_INTERVAL` (default `1h`) - how often a local cache size should be checked
* `CLEAN_LEVEL` (default `50`) - a local cache size fill ratio (in percents) triggering cache cleaning
* `WORKER_ALLOW_RUN_CPU_EXEC` (default `false`) - to be documented
* `WORKER_EXTRA_FLAGS` (default none) - to be documented

