from .default import *


THUMBNAIL_KVSTORE = 'sorl.thumbnail.kvstores.redis_kvstore.SentinelKVStore'


THUMBNAIL_SENTINEL_SERVICE_NAME = 'rmaster'
THUMBNAIL_SENTINEL_HOSTS = [
    ('sentinel1', 26379),
    ('sentinel2', 26379),
    ('sentinel3', 26379)
]
