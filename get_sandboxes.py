from sio.workers.sandbox import get_sandbox, SANDBOXES_URL

print 'downloading sandboxes from', SANDBOXES_URL

for s in ['compiler-fpc.2_6_2', 'compiler-gcc.4_8_2', 'exec-sandbox', 'null-sandbox', 'proot-sandbox', 'terrarium-sandbox']:
    print 'downloading', s
    get_sandbox(s).__enter__()
