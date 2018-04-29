import os

def application(env, start_response):
    start_response('200 OK', [('Content-Type', 'text/html')])
    if env['PATH_INFO'] == '/ip':
        return [os.popen("./get_ip.sh").read().encode()]
    else:
        return [open("./index.html", "rb").read()]