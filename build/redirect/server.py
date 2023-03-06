from os import environ
from base64 import b32decode
from aiohttp import web

DOMAIN = environ.get("DOMAIN", "")

async def handle(request):
    host = request.host.removesuffix(DOMAIN).strip('.').split('.')[-1]
    url = host.removesuffix('x').replace('-', '=')
    try:
        answer = b32decode(url, casefold=True).decode()
    except:
        raise web.HTTPUnprocessableEntity()

    raise web.HTTPMovedPermanently(answer)

app = web.Application()
app.add_routes([web.route('*', '/', handle)])

web.run_app(app)

