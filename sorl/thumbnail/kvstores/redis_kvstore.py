from __future__ import unicode_literals
import redis
from redis.sentinel import Sentinel
from django.core.exceptions import ImproperlyConfigured

from sorl.thumbnail.conf import settings
from sorl.thumbnail.kvstores.base import KVStoreBase


class KVStore(KVStoreBase):
    def __init__(self):
        super(KVStore, self).__init__()

        if hasattr(settings, 'THUMBNAIL_REDIS_URL'):
            self.connection = redis.from_url(settings.THUMBNAIL_REDIS_URL)
        else:
            self.connection = redis.Redis(
                host=settings.THUMBNAIL_REDIS_HOST,
                port=settings.THUMBNAIL_REDIS_PORT,
                db=settings.THUMBNAIL_REDIS_DB,
                password=settings.THUMBNAIL_REDIS_PASSWORD,
                unix_socket_path=settings.THUMBNAIL_REDIS_UNIX_SOCKET_PATH,
            )

    def _get_raw(self, key):
        return self.connection.get(key)

    def _set_raw(self, key, value):
        return self.connection.set(key, value)

    def _delete_raw(self, *keys):
        return self.connection.delete(*keys)

    def _find_keys_raw(self, prefix):
        pattern = prefix + '*'
        return list(map(lambda key: key.decode('utf-8'),
                        self.connection.keys(pattern=pattern)))


class SentinelKVStore(KVStoreBase):
    """
    Check sentinels format [(host, port),]
    Router reads to slaves
    Route writes to master
    """

    def __check_conf(self):
        if isinstance(self._sentinels, list) and len(self._sentinels):
            for s in self._sentinels:
                if not isinstance(s, tuple) or len(s) != 2:
                    return False
            return True
        else:
            return False

    def __init__(self):
        super(KVStoreBase, self).__init__()

        if not hasattr(settings, 'THUMBNAIL_SENTINEL_SERVICE_NAME'):
            raise ImproperlyConfigured(
                "THUMBNAIL_SENTINEL_SERVICE_NAME lacking in settings for SentinelKVStore"
            )
        else:
            self._service_name = getattr(settings, "THUMBNAIL_SENTINEL_SERVICE_NAME")
            self._sentinels = getattr(settings, "THUMBNAIL_SENTINEL_HOSTS")
            if not self.__check_conf():
                raise ImproperlyConfigured(
                    "THUMBNAIL_REDIS_SENTINEL_HOSTS should be at list with at least "
                    "1 tuple(host, port)")
            sentinel_conn_cls_kwargs = {
                "socket_timeout": getattr(settings, "THUMBNAIL_SENTINEL_SOCKET_TIMEOUT"),
                "socket_connect_timeout": getattr(
                    settings,
                    "THUMBNAIL_SENTINEL_SOCKET_CONNECT_TIMEOUT"
                ),
            }
            self._redis_conn_cls_kwargs = {
                "db": settings.THUMBNAIL_REDIS_DB,
                "password": settings.THUMBNAIL_REDIS_PASSWORD
            }
            self.sentinel = Sentinel(self._sentinels, **sentinel_conn_cls_kwargs)

    @property
    def _master(self):
        """
        Master connection
        :return: StrictRedis
        """
        return self.sentinel.master_for(self._service_name, **self._redis_conn_cls_kwargs)

    @property
    def _slave(self):
        """
        Slave connection (fallback to master if no slaves)
        :return: StrictRedis
        """
        return self.sentinel.slave_for(self._service_name, **self._redis_conn_cls_kwargs)

    def _get_raw(self, key):
        return self._slave.get(key)

    def _set_raw(self, key, value):
        return self._master.set(key, value)

    def _delete_raw(self, *keys):
        return self._master.delete(*keys)

    def _find_keys_raw(self, prefix):
        pattern = prefix + '*'
        return list(map(lambda key: key.decode('utf-8'),
                        self._slave.keys(pattern=pattern)))
