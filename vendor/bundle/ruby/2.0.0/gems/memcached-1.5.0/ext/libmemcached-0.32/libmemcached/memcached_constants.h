/*
 * Summary: Constants for libmemcached
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Brian Aker
 */

#ifndef __MEMCACHED_CONSTANTS_H__
#define __MEMCACHED_CONSTANTS_H__

/* Public defines */
#define MEMCACHED_DEFAULT_PORT 11211
#define MEMCACHED_MAX_KEY 251 /* We add one to have it null terminated */
#define MEMCACHED_MAX_BUFFER 8196
#define MEMCACHED_MAX_HOST_LENGTH 64
#define MEMCACHED_MAX_HOST_SORT_LENGTH 86 /* Used for Ketama */
#define MEMCACHED_POINTS_PER_SERVER 100
#define MEMCACHED_POINTS_PER_SERVER_KETAMA 160
#define MEMCACHED_CONTINUUM_SIZE MEMCACHED_POINTS_PER_SERVER*100 /* This would then set max hosts to 100 */
#define MEMCACHED_STRIDE 4
#define MEMCACHED_DEFAULT_TIMEOUT 1000
#define MEMCACHED_CONTINUUM_ADDITION 10 /* How many extra slots we should build for in the continuum */
#define MEMCACHED_PREFIX_KEY_MAX_SIZE 128
#define MEMCACHED_EXPIRATION_NOT_ADD 0xffffffffU

typedef enum {
  MEMCACHED_SUCCESS,
  MEMCACHED_FAILURE,
  MEMCACHED_HOST_LOOKUP_FAILURE,
  MEMCACHED_CONNECTION_FAILURE,
  MEMCACHED_CONNECTION_BIND_FAILURE,
  MEMCACHED_WRITE_FAILURE,
  MEMCACHED_READ_FAILURE,
  MEMCACHED_UNKNOWN_READ_FAILURE,
  MEMCACHED_PROTOCOL_ERROR,
  MEMCACHED_CLIENT_ERROR,
  MEMCACHED_SERVER_ERROR,
  MEMCACHED_CONNECTION_SOCKET_CREATE_FAILURE,
  MEMCACHED_DATA_EXISTS,
  MEMCACHED_DATA_DOES_NOT_EXIST,
  MEMCACHED_NOTSTORED,
  MEMCACHED_STORED,
  MEMCACHED_NOTFOUND,
  MEMCACHED_MEMORY_ALLOCATION_FAILURE,
  MEMCACHED_PARTIAL_READ,
  MEMCACHED_SOME_ERRORS,
  MEMCACHED_NO_SERVERS,
  MEMCACHED_END,
  MEMCACHED_DELETED,
  MEMCACHED_VALUE,
  MEMCACHED_STAT,
  MEMCACHED_ITEM,
  MEMCACHED_ERRNO,
  MEMCACHED_FAIL_UNIX_SOCKET,
  MEMCACHED_NOT_SUPPORTED,
  MEMCACHED_NO_KEY_PROVIDED, /* Deprecated. Use MEMCACHED_BAD_KEY_PROVIDED! */
  MEMCACHED_FETCH_NOTFINISHED,
  MEMCACHED_TIMEOUT,
  MEMCACHED_BUFFERED,
  MEMCACHED_BAD_KEY_PROVIDED,
  MEMCACHED_INVALID_HOST_PROTOCOL,
  MEMCACHED_SERVER_MARKED_DEAD,
  MEMCACHED_UNKNOWN_STAT_KEY,
  MEMCACHED_AUTH_PROBLEM,
  MEMCACHED_AUTH_FAILURE,
  MEMCACHED_AUTH_CONTINUE,
  MEMCACHED_MAXIMUM_RETURN /* Always add new error code before */
} memcached_return;

typedef enum {
  MEMCACHED_DISTRIBUTION_MODULA,
  MEMCACHED_DISTRIBUTION_CONSISTENT,
  MEMCACHED_DISTRIBUTION_CONSISTENT_KETAMA,
  MEMCACHED_DISTRIBUTION_RANDOM
} memcached_server_distribution;

typedef enum {
  MEMCACHED_BEHAVIOR_NO_BLOCK,
  MEMCACHED_BEHAVIOR_TCP_NODELAY,
  MEMCACHED_BEHAVIOR_HASH,
  MEMCACHED_BEHAVIOR_KETAMA,
  MEMCACHED_BEHAVIOR_SOCKET_SEND_SIZE,
  MEMCACHED_BEHAVIOR_SOCKET_RECV_SIZE,
  MEMCACHED_BEHAVIOR_CACHE_LOOKUPS,
  MEMCACHED_BEHAVIOR_SUPPORT_CAS,
  MEMCACHED_BEHAVIOR_POLL_TIMEOUT,
  MEMCACHED_BEHAVIOR_DISTRIBUTION,
  MEMCACHED_BEHAVIOR_BUFFER_REQUESTS,
  MEMCACHED_BEHAVIOR_USER_DATA,
  MEMCACHED_BEHAVIOR_SORT_HOSTS,
  MEMCACHED_BEHAVIOR_VERIFY_KEY,
  MEMCACHED_BEHAVIOR_CONNECT_TIMEOUT,
  MEMCACHED_BEHAVIOR_RETRY_TIMEOUT,
  MEMCACHED_BEHAVIOR_KETAMA_WEIGHTED,
  MEMCACHED_BEHAVIOR_KETAMA_HASH,
  MEMCACHED_BEHAVIOR_BINARY_PROTOCOL,
  MEMCACHED_BEHAVIOR_SND_TIMEOUT,
  MEMCACHED_BEHAVIOR_RCV_TIMEOUT,
  MEMCACHED_BEHAVIOR_SERVER_FAILURE_LIMIT,
  MEMCACHED_BEHAVIOR_IO_MSG_WATERMARK,
  MEMCACHED_BEHAVIOR_IO_BYTES_WATERMARK,
  MEMCACHED_BEHAVIOR_IO_KEY_PREFETCH,
  MEMCACHED_BEHAVIOR_HASH_WITH_PREFIX_KEY,
  MEMCACHED_BEHAVIOR_NOREPLY,
  MEMCACHED_BEHAVIOR_USE_UDP,
  MEMCACHED_BEHAVIOR_AUTO_EJECT_HOSTS
} memcached_behavior;

typedef enum {
  MEMCACHED_CALLBACK_PREFIX_KEY = 0,
  MEMCACHED_CALLBACK_USER_DATA = 1,
  MEMCACHED_CALLBACK_CLEANUP_FUNCTION = 2,
  MEMCACHED_CALLBACK_CLONE_FUNCTION = 3,
#ifdef MEMCACHED_ENABLE_DEPRECATED
  MEMCACHED_CALLBACK_MALLOC_FUNCTION = 4,
  MEMCACHED_CALLBACK_REALLOC_FUNCTION = 5,
  MEMCACHED_CALLBACK_FREE_FUNCTION = 6,
#endif
  MEMCACHED_CALLBACK_GET_FAILURE = 7,
  MEMCACHED_CALLBACK_DELETE_TRIGGER = 8
} memcached_callback;

typedef enum {
  MEMCACHED_HASH_DEFAULT= 0,
  MEMCACHED_HASH_MD5,
  MEMCACHED_HASH_CRC,
  MEMCACHED_HASH_FNV1_64,
  MEMCACHED_HASH_FNV1A_64,
  MEMCACHED_HASH_FNV1_32,
  MEMCACHED_HASH_FNV1A_32,
  MEMCACHED_HASH_HSIEH,
  MEMCACHED_HASH_MURMUR,
  MEMCACHED_HASH_JENKINS,
  MEMCACHED_HASH_NONE
} memcached_hash;

typedef enum {
  MEMCACHED_CONNECTION_UNKNOWN,
  MEMCACHED_CONNECTION_TCP,
  MEMCACHED_CONNECTION_UDP,
  MEMCACHED_CONNECTION_UNIX_SOCKET
} memcached_connection;

#endif /* __MEMCACHED_CONSTANTS_H__ */
