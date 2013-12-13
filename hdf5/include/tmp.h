# 1 "hdf5.h"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "hdf5.h"
# 24 "hdf5.h"
# 1 "H5public.h" 1
# 31 "H5public.h"
# 1 "H5pubconf.h" 1
# 32 "H5public.h" 2


# 1 "H5version.h" 1
# 35 "H5public.h" 2





# 1 "/usr/include/sys/types.h" 1 3 4
# 72 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/sys/appleapiopts.h" 1 3 4
# 73 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 406 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/sys/_symbol_aliasing.h" 1 3 4
# 407 "/usr/include/sys/cdefs.h" 2 3 4
# 472 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/sys/_posix_availability.h" 1 3 4
# 473 "/usr/include/sys/cdefs.h" 2 3 4
# 76 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/machine/types.h" 1 3 4
# 35 "/usr/include/machine/types.h" 3 4
# 1 "/usr/include/i386/types.h" 1 3 4
# 70 "/usr/include/i386/types.h" 3 4
# 1 "/usr/include/i386/_types.h" 1 3 4
# 37 "/usr/include/i386/_types.h" 3 4
typedef signed char __int8_t;



typedef unsigned char __uint8_t;
typedef short __int16_t;
typedef unsigned short __uint16_t;
typedef int __int32_t;
typedef unsigned int __uint32_t;
typedef long long __int64_t;
typedef unsigned long long __uint64_t;

typedef long __darwin_intptr_t;
typedef unsigned int __darwin_natural_t;
# 70 "/usr/include/i386/_types.h" 3 4
typedef int __darwin_ct_rune_t;





typedef union {
 char __mbstate8[128];
 long long _mbstateL;
} __mbstate_t;

typedef __mbstate_t __darwin_mbstate_t;


typedef long int __darwin_ptrdiff_t;





typedef long unsigned int __darwin_size_t;





typedef __builtin_va_list __darwin_va_list;





typedef int __darwin_wchar_t;




typedef __darwin_wchar_t __darwin_rune_t;


typedef int __darwin_wint_t;




typedef unsigned long __darwin_clock_t;
typedef __uint32_t __darwin_socklen_t;
typedef long __darwin_ssize_t;
typedef long __darwin_time_t;
# 71 "/usr/include/i386/types.h" 2 3 4







typedef signed char int8_t;

typedef unsigned char u_int8_t;


typedef short int16_t;

typedef unsigned short u_int16_t;


typedef int int32_t;

typedef unsigned int u_int32_t;


typedef long long int64_t;

typedef unsigned long long u_int64_t;


typedef int64_t register_t;






typedef __darwin_intptr_t intptr_t;



typedef unsigned long uintptr_t;




typedef u_int64_t user_addr_t;
typedef u_int64_t user_size_t;
typedef int64_t user_ssize_t;
typedef int64_t user_long_t;
typedef u_int64_t user_ulong_t;
typedef int64_t user_time_t;
typedef int64_t user_off_t;







typedef u_int64_t syscall_arg_t;
# 36 "/usr/include/machine/types.h" 2 3 4
# 79 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/sys/_types.h" 1 3 4
# 33 "/usr/include/sys/_types.h" 3 4
# 1 "/usr/include/machine/_types.h" 1 3 4
# 34 "/usr/include/sys/_types.h" 2 3 4
# 58 "/usr/include/sys/_types.h" 3 4
struct __darwin_pthread_handler_rec
{
 void (*__routine)(void *);
 void *__arg;
 struct __darwin_pthread_handler_rec *__next;
};
struct _opaque_pthread_attr_t { long __sig; char __opaque[56]; };
struct _opaque_pthread_cond_t { long __sig; char __opaque[40]; };
struct _opaque_pthread_condattr_t { long __sig; char __opaque[8]; };
struct _opaque_pthread_mutex_t { long __sig; char __opaque[56]; };
struct _opaque_pthread_mutexattr_t { long __sig; char __opaque[8]; };
struct _opaque_pthread_once_t { long __sig; char __opaque[8]; };
struct _opaque_pthread_rwlock_t { long __sig; char __opaque[192]; };
struct _opaque_pthread_rwlockattr_t { long __sig; char __opaque[16]; };
struct _opaque_pthread_t { long __sig; struct __darwin_pthread_handler_rec *__cleanup_stack; char __opaque[1168]; };
# 94 "/usr/include/sys/_types.h" 3 4
typedef __int64_t __darwin_blkcnt_t;
typedef __int32_t __darwin_blksize_t;
typedef __int32_t __darwin_dev_t;
typedef unsigned int __darwin_fsblkcnt_t;
typedef unsigned int __darwin_fsfilcnt_t;
typedef __uint32_t __darwin_gid_t;
typedef __uint32_t __darwin_id_t;
typedef __uint64_t __darwin_ino64_t;

typedef __darwin_ino64_t __darwin_ino_t;



typedef __darwin_natural_t __darwin_mach_port_name_t;
typedef __darwin_mach_port_name_t __darwin_mach_port_t;
typedef __uint16_t __darwin_mode_t;
typedef __int64_t __darwin_off_t;
typedef __int32_t __darwin_pid_t;
typedef struct _opaque_pthread_attr_t
   __darwin_pthread_attr_t;
typedef struct _opaque_pthread_cond_t
   __darwin_pthread_cond_t;
typedef struct _opaque_pthread_condattr_t
   __darwin_pthread_condattr_t;
typedef unsigned long __darwin_pthread_key_t;
typedef struct _opaque_pthread_mutex_t
   __darwin_pthread_mutex_t;
typedef struct _opaque_pthread_mutexattr_t
   __darwin_pthread_mutexattr_t;
typedef struct _opaque_pthread_once_t
   __darwin_pthread_once_t;
typedef struct _opaque_pthread_rwlock_t
   __darwin_pthread_rwlock_t;
typedef struct _opaque_pthread_rwlockattr_t
   __darwin_pthread_rwlockattr_t;
typedef struct _opaque_pthread_t
   *__darwin_pthread_t;
typedef __uint32_t __darwin_sigset_t;
typedef __int32_t __darwin_suseconds_t;
typedef __uint32_t __darwin_uid_t;
typedef __uint32_t __darwin_useconds_t;
typedef unsigned char __darwin_uuid_t[16];
typedef char __darwin_uuid_string_t[37];
# 80 "/usr/include/sys/types.h" 2 3 4

# 1 "/usr/include/machine/endian.h" 1 3 4
# 35 "/usr/include/machine/endian.h" 3 4
# 1 "/usr/include/i386/endian.h" 1 3 4
# 99 "/usr/include/i386/endian.h" 3 4
# 1 "/usr/include/sys/_endian.h" 1 3 4
# 124 "/usr/include/sys/_endian.h" 3 4
# 1 "/usr/include/libkern/_OSByteOrder.h" 1 3 4
# 66 "/usr/include/libkern/_OSByteOrder.h" 3 4
# 1 "/usr/include/libkern/i386/_OSByteOrder.h" 1 3 4
# 44 "/usr/include/libkern/i386/_OSByteOrder.h" 3 4
static __inline__
__uint16_t
_OSSwapInt16(
    __uint16_t _data
)
{
    return ((_data << 8) | (_data >> 8));
}

static __inline__
__uint32_t
_OSSwapInt32(
    __uint32_t _data
)
{

    return __builtin_bswap32(_data);




}


static __inline__
__uint64_t
_OSSwapInt64(
    __uint64_t _data
)
{
    return __builtin_bswap64(_data);
}
# 67 "/usr/include/libkern/_OSByteOrder.h" 2 3 4
# 125 "/usr/include/sys/_endian.h" 2 3 4
# 100 "/usr/include/i386/endian.h" 2 3 4
# 36 "/usr/include/machine/endian.h" 2 3 4
# 82 "/usr/include/sys/types.h" 2 3 4


typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned int u_int;

typedef unsigned long u_long;


typedef unsigned short ushort;
typedef unsigned int uint;


typedef u_int64_t u_quad_t;
typedef int64_t quad_t;
typedef quad_t * qaddr_t;

typedef char * caddr_t;
typedef int32_t daddr_t;


typedef __darwin_dev_t dev_t;



typedef u_int32_t fixpt_t;


typedef __darwin_blkcnt_t blkcnt_t;




typedef __darwin_blksize_t blksize_t;




typedef __darwin_gid_t gid_t;





typedef __uint32_t in_addr_t;




typedef __uint16_t in_port_t;



typedef __darwin_ino_t ino_t;





typedef __darwin_ino64_t ino64_t;






typedef __int32_t key_t;



typedef __darwin_mode_t mode_t;




typedef __uint16_t nlink_t;





typedef __darwin_id_t id_t;



typedef __darwin_pid_t pid_t;




typedef __darwin_off_t off_t;



typedef int32_t segsz_t;
typedef int32_t swblk_t;


typedef __darwin_uid_t uid_t;
# 223 "/usr/include/sys/types.h" 3 4
typedef __darwin_clock_t clock_t;






typedef __darwin_size_t size_t;




typedef __darwin_ssize_t ssize_t;




typedef __darwin_time_t time_t;




typedef __darwin_useconds_t useconds_t;




typedef __darwin_suseconds_t suseconds_t;
# 260 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/sys/_structs.h" 1 3 4
# 183 "/usr/include/sys/_structs.h" 3 4

typedef struct fd_set {
 __int32_t fds_bits[((((1024) % ((sizeof(__int32_t) * 8))) == 0) ? ((1024) / ((sizeof(__int32_t) * 8))) : (((1024) / ((sizeof(__int32_t) * 8))) + 1))];
} fd_set;



static __inline int
__darwin_fd_isset(int _n, const struct fd_set *_p)
{
 return (_p->fds_bits[_n/(sizeof(__int32_t) * 8)] & (1<<(_n % (sizeof(__int32_t) * 8))));
}
# 261 "/usr/include/sys/types.h" 2 3 4




typedef __int32_t fd_mask;
# 303 "/usr/include/sys/types.h" 3 4
typedef __darwin_pthread_attr_t pthread_attr_t;



typedef __darwin_pthread_cond_t pthread_cond_t;



typedef __darwin_pthread_condattr_t pthread_condattr_t;



typedef __darwin_pthread_mutex_t pthread_mutex_t;



typedef __darwin_pthread_mutexattr_t pthread_mutexattr_t;



typedef __darwin_pthread_once_t pthread_once_t;



typedef __darwin_pthread_rwlock_t pthread_rwlock_t;



typedef __darwin_pthread_rwlockattr_t pthread_rwlockattr_t;



typedef __darwin_pthread_t pthread_t;






typedef __darwin_pthread_key_t pthread_key_t;





typedef __darwin_fsblkcnt_t fsblkcnt_t;




typedef __darwin_fsfilcnt_t fsfilcnt_t;
# 41 "H5public.h" 2


# 1 "/usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include/limits.h" 1 3 4






# 1 "/usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include/syslimits.h" 1 3 4
# 8 "/usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include/limits.h" 2 3 4







# 1 "/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include/limits.h" 1 3 4






# 1 "/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include/syslimits.h" 1 3 4
# 8 "/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include/limits.h" 2 3 4







# 1 "/usr/include/limits.h" 1 3 4
# 64 "/usr/include/limits.h" 3 4
# 1 "/usr/include/machine/limits.h" 1 3 4





# 1 "/usr/include/i386/limits.h" 1 3 4
# 40 "/usr/include/i386/limits.h" 3 4
# 1 "/usr/include/i386/_limits.h" 1 3 4
# 41 "/usr/include/i386/limits.h" 2 3 4
# 7 "/usr/include/machine/limits.h" 2 3 4
# 65 "/usr/include/limits.h" 2 3 4
# 1 "/usr/include/sys/syslimits.h" 1 3 4
# 66 "/usr/include/limits.h" 2 3 4
# 16 "/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include/limits.h" 2 3 4
# 16 "/usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include/limits.h" 2 3 4
# 44 "H5public.h" 2



# 1 "/usr/include/stdint.h" 1 3 4
# 40 "/usr/include/stdint.h" 3 4
typedef unsigned char uint8_t;




typedef unsigned short uint16_t;




typedef unsigned int uint32_t;




typedef unsigned long long uint64_t;



typedef int8_t int_least8_t;
typedef int16_t int_least16_t;
typedef int32_t int_least32_t;
typedef int64_t int_least64_t;
typedef uint8_t uint_least8_t;
typedef uint16_t uint_least16_t;
typedef uint32_t uint_least32_t;
typedef uint64_t uint_least64_t;



typedef int8_t int_fast8_t;
typedef int16_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef int64_t int_fast64_t;
typedef uint8_t uint_fast8_t;
typedef uint16_t uint_fast16_t;
typedef uint32_t uint_fast32_t;
typedef uint64_t uint_fast64_t;
# 97 "/usr/include/stdint.h" 3 4
typedef long int intmax_t;
# 106 "/usr/include/stdint.h" 3 4
typedef long unsigned int uintmax_t;
# 48 "H5public.h" 2







# 1 "/usr/include/inttypes.h" 1 3 4
# 224 "/usr/include/inttypes.h" 3 4
# 1 "/usr/include/_types.h" 1 3 4
# 39 "/usr/include/_types.h" 3 4
typedef int __darwin_nl_item;
typedef int __darwin_wctrans_t;

typedef __uint32_t __darwin_wctype_t;
# 225 "/usr/include/inttypes.h" 2 3 4
# 235 "/usr/include/inttypes.h" 3 4



  extern intmax_t imaxabs(intmax_t j);


  typedef struct {
        intmax_t quot;
        intmax_t rem;
  } imaxdiv_t;

  extern imaxdiv_t imaxdiv(intmax_t numer, intmax_t denom);


  extern intmax_t strtoimax(const char * nptr, char ** endptr, int base);
  extern uintmax_t strtoumax(const char * nptr, char ** endptr, int base);




     typedef __darwin_wchar_t wchar_t;




  extern intmax_t wcstoimax(const wchar_t * nptr, wchar_t ** endptr, int base);
  extern uintmax_t wcstoumax(const wchar_t * nptr, wchar_t ** endptr, int base);







# 56 "H5public.h" 2


# 1 "/usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include/stddef.h" 1 3 4
# 152 "/usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include/stddef.h" 3 4
typedef long int ptrdiff_t;
# 59 "H5public.h" 2
# 69 "H5public.h"
# 1 "H5api_adpt.h" 1
# 70 "H5public.h" 2
# 107 "H5public.h"
typedef int herr_t;
# 125 "H5public.h"
typedef unsigned int hbool_t;
typedef int htri_t;
# 151 "H5public.h"
typedef unsigned long long hsize_t;
typedef signed long long hssize_t;
# 163 "H5public.h"
    typedef uint64_t haddr_t;
# 268 "H5public.h"
typedef enum {
    H5_ITER_UNKNOWN = -1,
    H5_ITER_INC,
    H5_ITER_DEC,
    H5_ITER_NATIVE,
    H5_ITER_N
} H5_iter_order_t;
# 289 "H5public.h"
typedef enum H5_index_t {
    H5_INDEX_UNKNOWN = -1,
    H5_INDEX_NAME,
    H5_INDEX_CRT_ORDER,
    H5_INDEX_N
} H5_index_t;




typedef struct H5_ih_info_t {
    hsize_t index_size;
    hsize_t heap_size;
} H5_ih_info_t;


 herr_t H5open(void);
 herr_t H5close(void);
 herr_t H5dont_atexit(void);
 herr_t H5garbage_collect(void);
 herr_t H5set_free_list_limits (int reg_global_lim, int reg_list_lim,
                int arr_global_lim, int arr_list_lim, int blk_global_lim,
                int blk_list_lim);
 herr_t H5get_libversion(unsigned *majnum, unsigned *minnum,
    unsigned *relnum);
 herr_t H5check_version(unsigned majnum, unsigned minnum,
          unsigned relnum);
# 25 "hdf5.h" 2
# 1 "H5Apublic.h" 1
# 23 "H5Apublic.h"
# 1 "H5Ipublic.h" 1
# 36 "H5Ipublic.h"
typedef enum H5I_type_t {
    H5I_UNINIT = (-2),
    H5I_BADID = (-1),
    H5I_FILE = 1,
    H5I_GROUP,
    H5I_DATATYPE,
    H5I_DATASPACE,
    H5I_DATASET,
    H5I_ATTR,
    H5I_REFERENCE,
    H5I_VFL,
    H5I_GENPROP_CLS,
    H5I_GENPROP_LST,
    H5I_ERROR_CLASS,
    H5I_ERROR_MSG,
    H5I_ERROR_STACK,
    H5I_NTYPES
} H5I_type_t;


typedef int hid_t;
# 69 "H5Ipublic.h"
typedef herr_t (*H5I_free_t)(void*);


typedef int (*H5I_search_func_t)(void *obj, hid_t id, void *key);







 hid_t H5Iregister(H5I_type_t type, const void *object);
 void *H5Iobject_verify(hid_t id, H5I_type_t id_type);
 void *H5Iremove_verify(hid_t id, H5I_type_t id_type);
 H5I_type_t H5Iget_type(hid_t id);
 hid_t H5Iget_file_id(hid_t id);
 ssize_t H5Iget_name(hid_t id, char *name , size_t size);
 int H5Iinc_ref(hid_t id);
 int H5Idec_ref(hid_t id);
 int H5Iget_ref(hid_t id);
 H5I_type_t H5Iregister_type(size_t hash_size, unsigned reserved, H5I_free_t free_func);
 herr_t H5Iclear_type(H5I_type_t type, hbool_t force);
 herr_t H5Idestroy_type(H5I_type_t type);
 int H5Iinc_type_ref(H5I_type_t type);
 int H5Idec_type_ref(H5I_type_t type);
 int H5Iget_type_ref(H5I_type_t type);
 void *H5Isearch(H5I_type_t type, H5I_search_func_t func, void *key);
 herr_t H5Inmembers(H5I_type_t type, hsize_t *num_members);
 htri_t H5Itype_exists(H5I_type_t type);
 htri_t H5Iis_valid(hid_t id);
# 24 "H5Apublic.h" 2
# 1 "H5Opublic.h" 1
# 33 "H5Opublic.h"
# 1 "H5Lpublic.h" 1
# 32 "H5Lpublic.h"
# 1 "H5Tpublic.h" 1
# 30 "H5Tpublic.h"
typedef enum H5T_class_t {
    H5T_NO_CLASS = -1,
    H5T_INTEGER = 0,
    H5T_FLOAT = 1,
    H5T_TIME = 2,
    H5T_STRING = 3,
    H5T_BITFIELD = 4,
    H5T_OPAQUE = 5,
    H5T_COMPOUND = 6,
    H5T_REFERENCE = 7,
    H5T_ENUM = 8,
    H5T_VLEN = 9,
    H5T_ARRAY = 10,

    H5T_NCLASSES
} H5T_class_t;


typedef enum H5T_order_t {
    H5T_ORDER_ERROR = -1,
    H5T_ORDER_LE = 0,
    H5T_ORDER_BE = 1,
    H5T_ORDER_VAX = 2,
    H5T_ORDER_MIXED = 3,
    H5T_ORDER_NONE = 4

} H5T_order_t;


typedef enum H5T_sign_t {
    H5T_SGN_ERROR = -1,
    H5T_SGN_NONE = 0,
    H5T_SGN_2 = 1,

    H5T_NSGN = 2
} H5T_sign_t;


typedef enum H5T_norm_t {
    H5T_NORM_ERROR = -1,
    H5T_NORM_IMPLIED = 0,
    H5T_NORM_MSBSET = 1,
    H5T_NORM_NONE = 2

} H5T_norm_t;





typedef enum H5T_cset_t {
    H5T_CSET_ERROR = -1,
    H5T_CSET_ASCII = 0,
    H5T_CSET_UTF8 = 1,
    H5T_CSET_RESERVED_2 = 2,
    H5T_CSET_RESERVED_3 = 3,
    H5T_CSET_RESERVED_4 = 4,
    H5T_CSET_RESERVED_5 = 5,
    H5T_CSET_RESERVED_6 = 6,
    H5T_CSET_RESERVED_7 = 7,
    H5T_CSET_RESERVED_8 = 8,
    H5T_CSET_RESERVED_9 = 9,
    H5T_CSET_RESERVED_10 = 10,
    H5T_CSET_RESERVED_11 = 11,
    H5T_CSET_RESERVED_12 = 12,
    H5T_CSET_RESERVED_13 = 13,
    H5T_CSET_RESERVED_14 = 14,
    H5T_CSET_RESERVED_15 = 15
} H5T_cset_t;






typedef enum H5T_str_t {
    H5T_STR_ERROR = -1,
    H5T_STR_NULLTERM = 0,
    H5T_STR_NULLPAD = 1,
    H5T_STR_SPACEPAD = 2,
    H5T_STR_RESERVED_3 = 3,
    H5T_STR_RESERVED_4 = 4,
    H5T_STR_RESERVED_5 = 5,
    H5T_STR_RESERVED_6 = 6,
    H5T_STR_RESERVED_7 = 7,
    H5T_STR_RESERVED_8 = 8,
    H5T_STR_RESERVED_9 = 9,
    H5T_STR_RESERVED_10 = 10,
    H5T_STR_RESERVED_11 = 11,
    H5T_STR_RESERVED_12 = 12,
    H5T_STR_RESERVED_13 = 13,
    H5T_STR_RESERVED_14 = 14,
    H5T_STR_RESERVED_15 = 15
} H5T_str_t;



typedef enum H5T_pad_t {
    H5T_PAD_ERROR = -1,
    H5T_PAD_ZERO = 0,
    H5T_PAD_ONE = 1,
    H5T_PAD_BACKGROUND = 2,

    H5T_NPAD = 3
} H5T_pad_t;


typedef enum H5T_cmd_t {
    H5T_CONV_INIT = 0,
    H5T_CONV_CONV = 1,
    H5T_CONV_FREE = 2
} H5T_cmd_t;


typedef enum H5T_bkg_t {
    H5T_BKG_NO = 0,
    H5T_BKG_TEMP = 1,
    H5T_BKG_YES = 2
} H5T_bkg_t;


typedef struct H5T_cdata_t {
    H5T_cmd_t command;
    H5T_bkg_t need_bkg;
    hbool_t recalc;
    void *priv;
} H5T_cdata_t;


typedef enum H5T_pers_t {
    H5T_PERS_DONTCARE = -1,
    H5T_PERS_HARD = 0,
    H5T_PERS_SOFT = 1
} H5T_pers_t;


typedef enum H5T_direction_t {
    H5T_DIR_DEFAULT = 0,
    H5T_DIR_ASCEND = 1,
    H5T_DIR_DESCEND = 2
} H5T_direction_t;


typedef enum H5T_conv_except_t {
    H5T_CONV_EXCEPT_RANGE_HI = 0,
    H5T_CONV_EXCEPT_RANGE_LOW = 1,
    H5T_CONV_EXCEPT_PRECISION = 2,
    H5T_CONV_EXCEPT_TRUNCATE = 3,
    H5T_CONV_EXCEPT_PINF = 4,
    H5T_CONV_EXCEPT_NINF = 5,
    H5T_CONV_EXCEPT_NAN = 6
} H5T_conv_except_t;


typedef enum H5T_conv_ret_t {
    H5T_CONV_ABORT = -1,
    H5T_CONV_UNHANDLED = 0,
    H5T_CONV_HANDLED = 1
} H5T_conv_ret_t;



typedef struct {
    size_t len;
    void *p;
} hvl_t;
# 209 "H5Tpublic.h"
typedef herr_t (*H5T_conv_t) (hid_t src_id, hid_t dst_id, H5T_cdata_t *cdata,
      size_t nelmts, size_t buf_stride, size_t bkg_stride, void *buf,
      void *bkg, hid_t dset_xfer_plist);




typedef H5T_conv_ret_t (*H5T_conv_except_func_t)(H5T_conv_except_t except_type,
    hid_t src_id, hid_t dst_id, void *src_buf, void *dst_buf, void *user_data);
# 234 "H5Tpublic.h"
extern hid_t H5T_IEEE_F32BE_g;
extern hid_t H5T_IEEE_F32LE_g;
extern hid_t H5T_IEEE_F64BE_g;
extern hid_t H5T_IEEE_F64LE_g;
# 269 "H5Tpublic.h"
extern hid_t H5T_STD_I8BE_g;
extern hid_t H5T_STD_I8LE_g;
extern hid_t H5T_STD_I16BE_g;
extern hid_t H5T_STD_I16LE_g;
extern hid_t H5T_STD_I32BE_g;
extern hid_t H5T_STD_I32LE_g;
extern hid_t H5T_STD_I64BE_g;
extern hid_t H5T_STD_I64LE_g;
extern hid_t H5T_STD_U8BE_g;
extern hid_t H5T_STD_U8LE_g;
extern hid_t H5T_STD_U16BE_g;
extern hid_t H5T_STD_U16LE_g;
extern hid_t H5T_STD_U32BE_g;
extern hid_t H5T_STD_U32LE_g;
extern hid_t H5T_STD_U64BE_g;
extern hid_t H5T_STD_U64LE_g;
extern hid_t H5T_STD_B8BE_g;
extern hid_t H5T_STD_B8LE_g;
extern hid_t H5T_STD_B16BE_g;
extern hid_t H5T_STD_B16LE_g;
extern hid_t H5T_STD_B32BE_g;
extern hid_t H5T_STD_B32LE_g;
extern hid_t H5T_STD_B64BE_g;
extern hid_t H5T_STD_B64LE_g;
extern hid_t H5T_STD_REF_OBJ_g;
extern hid_t H5T_STD_REF_DSETREG_g;
# 303 "H5Tpublic.h"
extern hid_t H5T_UNIX_D32BE_g;
extern hid_t H5T_UNIX_D32LE_g;
extern hid_t H5T_UNIX_D64BE_g;
extern hid_t H5T_UNIX_D64LE_g;






extern hid_t H5T_C_S1_g;





extern hid_t H5T_FORTRAN_S1_g;
# 383 "H5Tpublic.h"
extern hid_t H5T_VAX_F32_g;
extern hid_t H5T_VAX_F64_g;
# 421 "H5Tpublic.h"
extern hid_t H5T_NATIVE_SCHAR_g;
extern hid_t H5T_NATIVE_UCHAR_g;
extern hid_t H5T_NATIVE_SHORT_g;
extern hid_t H5T_NATIVE_USHORT_g;
extern hid_t H5T_NATIVE_INT_g;
extern hid_t H5T_NATIVE_UINT_g;
extern hid_t H5T_NATIVE_LONG_g;
extern hid_t H5T_NATIVE_ULONG_g;
extern hid_t H5T_NATIVE_LLONG_g;
extern hid_t H5T_NATIVE_ULLONG_g;
extern hid_t H5T_NATIVE_FLOAT_g;
extern hid_t H5T_NATIVE_DOUBLE_g;

extern hid_t H5T_NATIVE_LDOUBLE_g;

extern hid_t H5T_NATIVE_B8_g;
extern hid_t H5T_NATIVE_B16_g;
extern hid_t H5T_NATIVE_B32_g;
extern hid_t H5T_NATIVE_B64_g;
extern hid_t H5T_NATIVE_OPAQUE_g;
extern hid_t H5T_NATIVE_HADDR_g;
extern hid_t H5T_NATIVE_HSIZE_g;
extern hid_t H5T_NATIVE_HSSIZE_g;
extern hid_t H5T_NATIVE_HERR_g;
extern hid_t H5T_NATIVE_HBOOL_g;
# 454 "H5Tpublic.h"
extern hid_t H5T_NATIVE_INT8_g;
extern hid_t H5T_NATIVE_UINT8_g;
extern hid_t H5T_NATIVE_INT_LEAST8_g;
extern hid_t H5T_NATIVE_UINT_LEAST8_g;
extern hid_t H5T_NATIVE_INT_FAST8_g;
extern hid_t H5T_NATIVE_UINT_FAST8_g;







extern hid_t H5T_NATIVE_INT16_g;
extern hid_t H5T_NATIVE_UINT16_g;
extern hid_t H5T_NATIVE_INT_LEAST16_g;
extern hid_t H5T_NATIVE_UINT_LEAST16_g;
extern hid_t H5T_NATIVE_INT_FAST16_g;
extern hid_t H5T_NATIVE_UINT_FAST16_g;







extern hid_t H5T_NATIVE_INT32_g;
extern hid_t H5T_NATIVE_UINT32_g;
extern hid_t H5T_NATIVE_INT_LEAST32_g;
extern hid_t H5T_NATIVE_UINT_LEAST32_g;
extern hid_t H5T_NATIVE_INT_FAST32_g;
extern hid_t H5T_NATIVE_UINT_FAST32_g;







extern hid_t H5T_NATIVE_INT64_g;
extern hid_t H5T_NATIVE_UINT64_g;
extern hid_t H5T_NATIVE_INT_LEAST64_g;
extern hid_t H5T_NATIVE_UINT_LEAST64_g;
extern hid_t H5T_NATIVE_INT_FAST64_g;
extern hid_t H5T_NATIVE_UINT_FAST64_g;


 hid_t H5Tcreate(H5T_class_t type, size_t size);
 hid_t H5Tcopy(hid_t type_id);
 herr_t H5Tclose(hid_t type_id);
 htri_t H5Tequal(hid_t type1_id, hid_t type2_id);
 herr_t H5Tlock(hid_t type_id);
 herr_t H5Tcommit2(hid_t loc_id, const char *name, hid_t type_id,
    hid_t lcpl_id, hid_t tcpl_id, hid_t tapl_id);
 hid_t H5Topen2(hid_t loc_id, const char *name, hid_t tapl_id);
 herr_t H5Tcommit_anon(hid_t loc_id, hid_t type_id, hid_t tcpl_id, hid_t tapl_id);
 hid_t H5Tget_create_plist(hid_t type_id);
 htri_t H5Tcommitted(hid_t type_id);
 herr_t H5Tencode(hid_t obj_id, void *buf, size_t *nalloc);
 hid_t H5Tdecode(const void *buf);


 herr_t H5Tinsert(hid_t parent_id, const char *name, size_t offset,
    hid_t member_id);
 herr_t H5Tpack(hid_t type_id);


 hid_t H5Tenum_create(hid_t base_id);
 herr_t H5Tenum_insert(hid_t type, const char *name, const void *value);
 herr_t H5Tenum_nameof(hid_t type, const void *value, char *name ,
        size_t size);
 herr_t H5Tenum_valueof(hid_t type, const char *name,
         void *value );


 hid_t H5Tvlen_create(hid_t base_id);


 hid_t H5Tarray_create2(hid_t base_id, unsigned ndims,
            const hsize_t dim[ ]);
 int H5Tget_array_ndims(hid_t type_id);
 int H5Tget_array_dims2(hid_t type_id, hsize_t dims[]);


 herr_t H5Tset_tag(hid_t type, const char *tag);
 char *H5Tget_tag(hid_t type);


 hid_t H5Tget_super(hid_t type);
 H5T_class_t H5Tget_class(hid_t type_id);
 htri_t H5Tdetect_class(hid_t type_id, H5T_class_t cls);
 size_t H5Tget_size(hid_t type_id);
 H5T_order_t H5Tget_order(hid_t type_id);
 size_t H5Tget_precision(hid_t type_id);
 int H5Tget_offset(hid_t type_id);
 herr_t H5Tget_pad(hid_t type_id, H5T_pad_t *lsb ,
     H5T_pad_t *msb );
 H5T_sign_t H5Tget_sign(hid_t type_id);
 herr_t H5Tget_fields(hid_t type_id, size_t *spos ,
        size_t *epos , size_t *esize ,
        size_t *mpos , size_t *msize );
 size_t H5Tget_ebias(hid_t type_id);
 H5T_norm_t H5Tget_norm(hid_t type_id);
 H5T_pad_t H5Tget_inpad(hid_t type_id);
 H5T_str_t H5Tget_strpad(hid_t type_id);
 int H5Tget_nmembers(hid_t type_id);
 char *H5Tget_member_name(hid_t type_id, unsigned membno);
 int H5Tget_member_index(hid_t type_id, const char *name);
 size_t H5Tget_member_offset(hid_t type_id, unsigned membno);
 H5T_class_t H5Tget_member_class(hid_t type_id, unsigned membno);
 hid_t H5Tget_member_type(hid_t type_id, unsigned membno);
 herr_t H5Tget_member_value(hid_t type_id, unsigned membno, void *value );
 H5T_cset_t H5Tget_cset(hid_t type_id);
 htri_t H5Tis_variable_str(hid_t type_id);
 hid_t H5Tget_native_type(hid_t type_id, H5T_direction_t direction);


 herr_t H5Tset_size(hid_t type_id, size_t size);
 herr_t H5Tset_order(hid_t type_id, H5T_order_t order);
 herr_t H5Tset_precision(hid_t type_id, size_t prec);
 herr_t H5Tset_offset(hid_t type_id, size_t offset);
 herr_t H5Tset_pad(hid_t type_id, H5T_pad_t lsb, H5T_pad_t msb);
 herr_t H5Tset_sign(hid_t type_id, H5T_sign_t sign);
 herr_t H5Tset_fields(hid_t type_id, size_t spos, size_t epos,
        size_t esize, size_t mpos, size_t msize);
 herr_t H5Tset_ebias(hid_t type_id, size_t ebias);
 herr_t H5Tset_norm(hid_t type_id, H5T_norm_t norm);
 herr_t H5Tset_inpad(hid_t type_id, H5T_pad_t pad);
 herr_t H5Tset_cset(hid_t type_id, H5T_cset_t cset);
 herr_t H5Tset_strpad(hid_t type_id, H5T_str_t strpad);


 herr_t H5Tregister(H5T_pers_t pers, const char *name, hid_t src_id,
      hid_t dst_id, H5T_conv_t func);
 herr_t H5Tunregister(H5T_pers_t pers, const char *name, hid_t src_id,
        hid_t dst_id, H5T_conv_t func);
 H5T_conv_t H5Tfind(hid_t src_id, hid_t dst_id, H5T_cdata_t **pcdata);
 htri_t H5Tcompiler_conv(hid_t src_id, hid_t dst_id);
 herr_t H5Tconvert(hid_t src_id, hid_t dst_id, size_t nelmts,
     void *buf, void *background, hid_t plist_id);
# 608 "H5Tpublic.h"
 herr_t H5Tcommit1(hid_t loc_id, const char *name, hid_t type_id);
 hid_t H5Topen1(hid_t loc_id, const char *name);
 hid_t H5Tarray_create1(hid_t base_id, int ndims,
            const hsize_t dim[ ],
            const int perm[ ]);
 int H5Tget_array_dims1(hid_t type_id, hsize_t dims[], int perm[]);
# 33 "H5Lpublic.h" 2
# 64 "H5Lpublic.h"
typedef enum {
    H5L_TYPE_ERROR = (-1),
    H5L_TYPE_HARD = 0,
    H5L_TYPE_SOFT = 1,
    H5L_TYPE_EXTERNAL = 64,
    H5L_TYPE_MAX = 255
} H5L_type_t;




typedef struct {
    H5L_type_t type;
    hbool_t corder_valid;
    int64_t corder;
    H5T_cset_t cset;
    union {
        haddr_t address;
        size_t val_size;
    } u;
} H5L_info_t;







typedef herr_t (*H5L_create_func_t)(const char *link_name, hid_t loc_group,
    const void *lnkdata, size_t lnkdata_size, hid_t lcpl_id);


typedef herr_t (*H5L_move_func_t)(const char *new_name, hid_t new_loc,
    const void *lnkdata, size_t lnkdata_size);


typedef herr_t (*H5L_copy_func_t)(const char *new_name, hid_t new_loc,
    const void *lnkdata, size_t lnkdata_size);


typedef herr_t (*H5L_traverse_func_t)(const char *link_name, hid_t cur_group,
    const void *lnkdata, size_t lnkdata_size, hid_t lapl_id);


typedef herr_t (*H5L_delete_func_t)(const char *link_name, hid_t file,
    const void *lnkdata, size_t lnkdata_size);



typedef ssize_t (*H5L_query_func_t)(const char *link_name, const void *lnkdata,
    size_t lnkdata_size, void *buf , size_t buf_size);


typedef struct {
    int version;
    H5L_type_t id;
    const char *comment;
    H5L_create_func_t create_func;
    H5L_move_func_t move_func;
    H5L_copy_func_t copy_func;
    H5L_traverse_func_t trav_func;
    H5L_delete_func_t del_func;
    H5L_query_func_t query_func;
} H5L_class_t;


typedef herr_t (*H5L_iterate_t)(hid_t group, const char *name, const H5L_info_t *info,
    void *op_data);


typedef herr_t (*H5L_elink_traverse_t)(const char *parent_file_name,
    const char *parent_group_name, const char *child_file_name,
    const char *child_object_name, unsigned *acc_flags, hid_t fapl_id,
    void *op_data);
# 148 "H5Lpublic.h"
 herr_t H5Lmove(hid_t src_loc, const char *src_name, hid_t dst_loc,
    const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
 herr_t H5Lcopy(hid_t src_loc, const char *src_name, hid_t dst_loc,
    const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
 herr_t H5Lcreate_hard(hid_t cur_loc, const char *cur_name,
    hid_t dst_loc, const char *dst_name, hid_t lcpl_id, hid_t lapl_id);
 herr_t H5Lcreate_soft(const char *link_target, hid_t link_loc_id,
    const char *link_name, hid_t lcpl_id, hid_t lapl_id);
 herr_t H5Ldelete(hid_t loc_id, const char *name, hid_t lapl_id);
 herr_t H5Ldelete_by_idx(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
 herr_t H5Lget_val(hid_t loc_id, const char *name, void *buf ,
    size_t size, hid_t lapl_id);
 herr_t H5Lget_val_by_idx(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
    void *buf , size_t size, hid_t lapl_id);
 htri_t H5Lexists(hid_t loc_id, const char *name, hid_t lapl_id);
 herr_t H5Lget_info(hid_t loc_id, const char *name,
    H5L_info_t *linfo , hid_t lapl_id);
 herr_t H5Lget_info_by_idx(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
    H5L_info_t *linfo , hid_t lapl_id);
 ssize_t H5Lget_name_by_idx(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
    char *name , size_t size, hid_t lapl_id);
 herr_t H5Literate(hid_t grp_id, H5_index_t idx_type,
    H5_iter_order_t order, hsize_t *idx, H5L_iterate_t op, void *op_data);
 herr_t H5Literate_by_name(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t *idx,
    H5L_iterate_t op, void *op_data, hid_t lapl_id);
 herr_t H5Lvisit(hid_t grp_id, H5_index_t idx_type, H5_iter_order_t order,
    H5L_iterate_t op, void *op_data);
 herr_t H5Lvisit_by_name(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, H5L_iterate_t op,
    void *op_data, hid_t lapl_id);


 herr_t H5Lcreate_ud(hid_t link_loc_id, const char *link_name,
    H5L_type_t link_type, const void *udata, size_t udata_size, hid_t lcpl_id,
    hid_t lapl_id);
 herr_t H5Lregister(const H5L_class_t *cls);
 herr_t H5Lunregister(H5L_type_t id);
 htri_t H5Lis_registered(H5L_type_t id);


 herr_t H5Lunpack_elink_val(const void *ext_linkval , size_t link_size,
   unsigned *flags, const char **filename , const char **obj_path );
 herr_t H5Lcreate_external(const char *file_name, const char *obj_name,
    hid_t link_loc_id, const char *link_name, hid_t lcpl_id, hid_t lapl_id);
# 34 "H5Opublic.h" 2
# 83 "H5Opublic.h"
typedef enum H5O_type_t {
    H5O_TYPE_UNKNOWN = -1,
    H5O_TYPE_GROUP,
    H5O_TYPE_DATASET,
    H5O_TYPE_NAMED_DATATYPE,
    H5O_TYPE_NTYPES
} H5O_type_t;


typedef struct H5O_hdr_info_t {
    unsigned version;
    unsigned nmesgs;
    unsigned nchunks;
    unsigned flags;
    struct {
        hsize_t total;
        hsize_t meta;
        hsize_t mesg;
        hsize_t free;
    } space;
    struct {
        uint64_t present;
        uint64_t shared;
    } mesg;
} H5O_hdr_info_t;


typedef struct H5O_info_t {
    unsigned long fileno;
    haddr_t addr;
    H5O_type_t type;
    unsigned rc;
    time_t atime;
    time_t mtime;
    time_t ctime;
    time_t btime;
    hsize_t num_attrs;
    H5O_hdr_info_t hdr;

    struct {
        H5_ih_info_t obj;
        H5_ih_info_t attr;
    } meta_size;
} H5O_info_t;


typedef uint32_t H5O_msg_crt_idx_t;


typedef herr_t (*H5O_iterate_t)(hid_t obj, const char *name, const H5O_info_t *info,
    void *op_data);

typedef enum H5O_mcdt_search_ret_t {
    H5O_MCDT_SEARCH_ERROR = -1,
    H5O_MCDT_SEARCH_CONT,
    H5O_MCDT_SEARCH_STOP
} H5O_mcdt_search_ret_t;


typedef H5O_mcdt_search_ret_t (*H5O_mcdt_search_cb_t)(void *op_data);
# 156 "H5Opublic.h"
 hid_t H5Oopen(hid_t loc_id, const char *name, hid_t lapl_id);
 hid_t H5Oopen_by_addr(hid_t loc_id, haddr_t addr);
 hid_t H5Oopen_by_idx(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
 htri_t H5Oexists_by_name(hid_t loc_id, const char *name, hid_t lapl_id);
 herr_t H5Oget_info(hid_t loc_id, H5O_info_t *oinfo);
 herr_t H5Oget_info_by_name(hid_t loc_id, const char *name, H5O_info_t *oinfo,
    hid_t lapl_id);
 herr_t H5Oget_info_by_idx(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n, H5O_info_t *oinfo,
    hid_t lapl_id);
 herr_t H5Olink(hid_t obj_id, hid_t new_loc_id, const char *new_name,
    hid_t lcpl_id, hid_t lapl_id);
 herr_t H5Oincr_refcount(hid_t object_id);
 herr_t H5Odecr_refcount(hid_t object_id);
 herr_t H5Ocopy(hid_t src_loc_id, const char *src_name, hid_t dst_loc_id,
    const char *dst_name, hid_t ocpypl_id, hid_t lcpl_id);
 herr_t H5Oset_comment(hid_t obj_id, const char *comment);
 herr_t H5Oset_comment_by_name(hid_t loc_id, const char *name,
    const char *comment, hid_t lapl_id);
 ssize_t H5Oget_comment(hid_t obj_id, char *comment, size_t bufsize);
 ssize_t H5Oget_comment_by_name(hid_t loc_id, const char *name,
    char *comment, size_t bufsize, hid_t lapl_id);
 herr_t H5Ovisit(hid_t obj_id, H5_index_t idx_type, H5_iter_order_t order,
    H5O_iterate_t op, void *op_data);
 herr_t H5Ovisit_by_name(hid_t loc_id, const char *obj_name,
    H5_index_t idx_type, H5_iter_order_t order, H5O_iterate_t op,
    void *op_data, hid_t lapl_id);
 herr_t H5Oclose(hid_t object_id);
# 197 "H5Opublic.h"
typedef struct H5O_stat_t {
    hsize_t size;
    hsize_t free;
    unsigned nmesgs;
    unsigned nchunks;
} H5O_stat_t;
# 25 "H5Apublic.h" 2







typedef struct {
    hbool_t corder_valid;
    H5O_msg_crt_idx_t corder;
    H5T_cset_t cset;
    hsize_t data_size;
} H5A_info_t;


typedef herr_t (*H5A_operator2_t)(hid_t location_id ,
    const char *attr_name , const H5A_info_t *ainfo , void *op_data );


 hid_t H5Acreate2(hid_t loc_id, const char *attr_name, hid_t type_id,
    hid_t space_id, hid_t acpl_id, hid_t aapl_id);
 hid_t H5Acreate_by_name(hid_t loc_id, const char *obj_name, const char *attr_name,
    hid_t type_id, hid_t space_id, hid_t acpl_id, hid_t aapl_id, hid_t lapl_id);
 hid_t H5Aopen(hid_t obj_id, const char *attr_name, hid_t aapl_id);
 hid_t H5Aopen_by_name(hid_t loc_id, const char *obj_name,
    const char *attr_name, hid_t aapl_id, hid_t lapl_id);
 hid_t H5Aopen_by_idx(hid_t loc_id, const char *obj_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t aapl_id,
    hid_t lapl_id);
 herr_t H5Awrite(hid_t attr_id, hid_t type_id, const void *buf);
 herr_t H5Aread(hid_t attr_id, hid_t type_id, void *buf);
 herr_t H5Aclose(hid_t attr_id);
 hid_t H5Aget_space(hid_t attr_id);
 hid_t H5Aget_type(hid_t attr_id);
 hid_t H5Aget_create_plist(hid_t attr_id);
 ssize_t H5Aget_name(hid_t attr_id, size_t buf_size, char *buf);
 ssize_t H5Aget_name_by_idx(hid_t loc_id, const char *obj_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
    char *name , size_t size, hid_t lapl_id);
 hsize_t H5Aget_storage_size(hid_t attr_id);
 herr_t H5Aget_info(hid_t attr_id, H5A_info_t *ainfo );
 herr_t H5Aget_info_by_name(hid_t loc_id, const char *obj_name,
    const char *attr_name, H5A_info_t *ainfo , hid_t lapl_id);
 herr_t H5Aget_info_by_idx(hid_t loc_id, const char *obj_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n,
    H5A_info_t *ainfo , hid_t lapl_id);
 herr_t H5Arename(hid_t loc_id, const char *old_name, const char *new_name);
 herr_t H5Arename_by_name(hid_t loc_id, const char *obj_name,
    const char *old_attr_name, const char *new_attr_name, hid_t lapl_id);
 herr_t H5Aiterate2(hid_t loc_id, H5_index_t idx_type,
    H5_iter_order_t order, hsize_t *idx, H5A_operator2_t op, void *op_data);
 herr_t H5Aiterate_by_name(hid_t loc_id, const char *obj_name, H5_index_t idx_type,
    H5_iter_order_t order, hsize_t *idx, H5A_operator2_t op, void *op_data,
    hid_t lapd_id);
 herr_t H5Adelete(hid_t loc_id, const char *name);
 herr_t H5Adelete_by_name(hid_t loc_id, const char *obj_name,
    const char *attr_name, hid_t lapl_id);
 herr_t H5Adelete_by_idx(hid_t loc_id, const char *obj_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n, hid_t lapl_id);
 htri_t H5Aexists(hid_t obj_id, const char *attr_name);
 htri_t H5Aexists_by_name(hid_t obj_id, const char *obj_name,
    const char *attr_name, hid_t lapl_id);
# 100 "H5Apublic.h"
typedef herr_t (*H5A_operator1_t)(hid_t location_id ,
    const char *attr_name , void *operator_data );



 hid_t H5Acreate1(hid_t loc_id, const char *name, hid_t type_id,
    hid_t space_id, hid_t acpl_id);
 hid_t H5Aopen_name(hid_t loc_id, const char *name);
 hid_t H5Aopen_idx(hid_t loc_id, unsigned idx);
 int H5Aget_num_attrs(hid_t loc_id);
 herr_t H5Aiterate1(hid_t loc_id, unsigned *attr_num, H5A_operator1_t op,
    void *op_data);
# 26 "hdf5.h" 2
# 1 "H5ACpublic.h" 1
# 33 "H5ACpublic.h"
# 1 "H5Cpublic.h" 1
# 38 "H5Cpublic.h"
enum H5C_cache_incr_mode
{
    H5C_incr__off,
    H5C_incr__threshold
};

enum H5C_cache_flash_incr_mode
{
     H5C_flash_incr__off,
     H5C_flash_incr__add_space
};

enum H5C_cache_decr_mode
{
    H5C_decr__off,
    H5C_decr__threshold,
    H5C_decr__age_out,
    H5C_decr__age_out_with_threshold
};
# 34 "H5ACpublic.h" 2
# 443 "H5ACpublic.h"
typedef struct H5AC_cache_config_t
{

    int version;

    hbool_t rpt_fcn_enabled;

    hbool_t open_trace_file;
    hbool_t close_trace_file;
    char trace_file_name[1024 + 1];

    hbool_t evictions_enabled;

    hbool_t set_initial_size;
    size_t initial_size;

    double min_clean_fraction;

    size_t max_size;
    size_t min_size;

    long int epoch_length;



    enum H5C_cache_incr_mode incr_mode;

    double lower_hr_threshold;

    double increment;

    hbool_t apply_max_increment;
    size_t max_increment;

    enum H5C_cache_flash_incr_mode flash_incr_mode;
    double flash_multiple;
    double flash_threshold;



    enum H5C_cache_decr_mode decr_mode;

    double upper_hr_threshold;

    double decrement;

    hbool_t apply_max_decrement;
    size_t max_decrement;

    int epochs_before_eviction;

    hbool_t apply_empty_reserve;
    double empty_reserve;



    int dirty_bytes_threshold;
    int metadata_write_strategy;

} H5AC_cache_config_t;
# 27 "hdf5.h" 2
# 1 "H5Dpublic.h" 1
# 48 "H5Dpublic.h"
typedef enum H5D_layout_t {
    H5D_LAYOUT_ERROR = -1,

    H5D_COMPACT = 0,
    H5D_CONTIGUOUS = 1,
    H5D_CHUNKED = 2,
    H5D_NLAYOUTS = 3
} H5D_layout_t;


typedef enum H5D_chunk_index_t {
    H5D_CHUNK_BTREE = 0
} H5D_chunk_index_t;


typedef enum H5D_alloc_time_t {
    H5D_ALLOC_TIME_ERROR = -1,
    H5D_ALLOC_TIME_DEFAULT = 0,
    H5D_ALLOC_TIME_EARLY = 1,
    H5D_ALLOC_TIME_LATE = 2,
    H5D_ALLOC_TIME_INCR = 3
} H5D_alloc_time_t;


typedef enum H5D_space_status_t {
    H5D_SPACE_STATUS_ERROR = -1,
    H5D_SPACE_STATUS_NOT_ALLOCATED = 0,
    H5D_SPACE_STATUS_PART_ALLOCATED = 1,
    H5D_SPACE_STATUS_ALLOCATED = 2
} H5D_space_status_t;


typedef enum H5D_fill_time_t {
    H5D_FILL_TIME_ERROR = -1,
    H5D_FILL_TIME_ALLOC = 0,
    H5D_FILL_TIME_NEVER = 1,
    H5D_FILL_TIME_IFSET = 2
} H5D_fill_time_t;


typedef enum H5D_fill_value_t {
    H5D_FILL_VALUE_ERROR =-1,
    H5D_FILL_VALUE_UNDEFINED =0,
    H5D_FILL_VALUE_DEFAULT =1,
    H5D_FILL_VALUE_USER_DEFINED =2
} H5D_fill_value_t;
# 107 "H5Dpublic.h"
typedef herr_t (*H5D_operator_t)(void *elem, hid_t type_id, unsigned ndim,
     const hsize_t *point, void *operator_data);


typedef herr_t (*H5D_scatter_func_t)(const void **src_buf ,
                                     size_t *src_buf_bytes_used ,
                                     void *op_data);


typedef herr_t (*H5D_gather_func_t)(const void *dst_buf,
                                    size_t dst_buf_bytes_used, void *op_data);

 hid_t H5Dcreate2(hid_t loc_id, const char *name, hid_t type_id,
    hid_t space_id, hid_t lcpl_id, hid_t dcpl_id, hid_t dapl_id);
 hid_t H5Dcreate_anon(hid_t file_id, hid_t type_id, hid_t space_id,
    hid_t plist_id, hid_t dapl_id);
 hid_t H5Dopen2(hid_t file_id, const char *name, hid_t dapl_id);
 herr_t H5Dclose(hid_t dset_id);
 hid_t H5Dget_space(hid_t dset_id);
 herr_t H5Dget_space_status(hid_t dset_id, H5D_space_status_t *allocation);
 hid_t H5Dget_type(hid_t dset_id);
 hid_t H5Dget_create_plist(hid_t dset_id);
 hid_t H5Dget_access_plist(hid_t dset_id);
 hsize_t H5Dget_storage_size(hid_t dset_id);
 haddr_t H5Dget_offset(hid_t dset_id);
 herr_t H5Dread(hid_t dset_id, hid_t mem_type_id, hid_t mem_space_id,
   hid_t file_space_id, hid_t plist_id, void *buf );
 herr_t H5Dwrite(hid_t dset_id, hid_t mem_type_id, hid_t mem_space_id,
    hid_t file_space_id, hid_t plist_id, const void *buf);
 herr_t H5Diterate(void *buf, hid_t type_id, hid_t space_id,
            H5D_operator_t op, void *operator_data);
 herr_t H5Dvlen_reclaim(hid_t type_id, hid_t space_id, hid_t plist_id, void *buf);
 herr_t H5Dvlen_get_buf_size(hid_t dataset_id, hid_t type_id, hid_t space_id, hsize_t *size);
 herr_t H5Dfill(const void *fill, hid_t fill_type, void *buf,
        hid_t buf_type, hid_t space);
 herr_t H5Dset_extent(hid_t dset_id, const hsize_t size[]);
 herr_t H5Dscatter(H5D_scatter_func_t op, void *op_data, hid_t type_id,
    hid_t dst_space_id, void *dst_buf);
 herr_t H5Dgather(hid_t src_space_id, const void *src_buf, hid_t type_id,
    size_t dst_buf_size, void *dst_buf, H5D_gather_func_t op, void *op_data);
 herr_t H5Ddebug(hid_t dset_id);
# 162 "H5Dpublic.h"
 hid_t H5Dcreate1(hid_t file_id, const char *name, hid_t type_id,
    hid_t space_id, hid_t dcpl_id);
 hid_t H5Dopen1(hid_t file_id, const char *name);
 herr_t H5Dextend(hid_t dset_id, const hsize_t size[]);
# 28 "hdf5.h" 2
# 1 "H5Epublic.h" 1
# 22 "H5Epublic.h"
# 1 "/usr/include/stdio.h" 1 3 4
# 65 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/Availability.h" 1 3 4
# 144 "/usr/include/Availability.h" 3 4
# 1 "/usr/include/AvailabilityInternal.h" 1 3 4
# 145 "/usr/include/Availability.h" 2 3 4
# 66 "/usr/include/stdio.h" 2 3 4







typedef __darwin_va_list va_list;
# 85 "/usr/include/stdio.h" 3 4
typedef __darwin_off_t fpos_t;
# 96 "/usr/include/stdio.h" 3 4
struct __sbuf {
 unsigned char *_base;
 int _size;
};


struct __sFILEX;
# 130 "/usr/include/stdio.h" 3 4
typedef struct __sFILE {
 unsigned char *_p;
 int _r;
 int _w;
 short _flags;
 short _file;
 struct __sbuf _bf;
 int _lbfsize;


 void *_cookie;
 int (*_close)(void *);
 int (*_read) (void *, char *, int);
 fpos_t (*_seek) (void *, fpos_t, int);
 int (*_write)(void *, const char *, int);


 struct __sbuf _ub;
 struct __sFILEX *_extra;
 int _ur;


 unsigned char _ubuf[3];
 unsigned char _nbuf[1];


 struct __sbuf _lb;


 int _blksize;
 fpos_t _offset;
} FILE;


extern FILE *__stdinp;
extern FILE *__stdoutp;
extern FILE *__stderrp;

# 238 "/usr/include/stdio.h" 3 4

void clearerr(FILE *);
int fclose(FILE *);
int feof(FILE *);
int ferror(FILE *);
int fflush(FILE *);
int fgetc(FILE *);
int fgetpos(FILE * , fpos_t *);
char *fgets(char * , int, FILE *);



FILE *fopen(const char * , const char * ) __asm("_" "fopen" );

int fprintf(FILE * , const char * , ...) __attribute__((__format__ (__printf__, 2, 3)));
int fputc(int, FILE *);
int fputs(const char * , FILE * ) __asm("_" "fputs" );
size_t fread(void * , size_t, size_t, FILE * );
FILE *freopen(const char * , const char * ,
                 FILE * ) __asm("_" "freopen" );
int fscanf(FILE * , const char * , ...) __attribute__((__format__ (__scanf__, 2, 3)));
int fseek(FILE *, long, int);
int fsetpos(FILE *, const fpos_t *);
long ftell(FILE *);
size_t fwrite(const void * , size_t, size_t, FILE * ) __asm("_" "fwrite" );
int getc(FILE *);
int getchar(void);
char *gets(char *);
void perror(const char *);
int printf(const char * , ...) __attribute__((__format__ (__printf__, 1, 2)));
int putc(int, FILE *);
int putchar(int);
int puts(const char *);
int remove(const char *);
int rename (const char *, const char *);
void rewind(FILE *);
int scanf(const char * , ...) __attribute__((__format__ (__scanf__, 1, 2)));
void setbuf(FILE * , char * );
int setvbuf(FILE * , char * , int, size_t);
int sprintf(char * , const char * , ...) __attribute__((__format__ (__printf__, 2, 3)));
int sscanf(const char * , const char * , ...) __attribute__((__format__ (__scanf__, 2, 3)));
FILE *tmpfile(void);
char *tmpnam(char *);
int ungetc(int, FILE *);
int vfprintf(FILE * , const char * , va_list) __attribute__((__format__ (__printf__, 2, 0)));
int vprintf(const char * , va_list) __attribute__((__format__ (__printf__, 1, 0)));
int vsprintf(char * , const char * , va_list) __attribute__((__format__ (__printf__, 2, 0)));

# 296 "/usr/include/stdio.h" 3 4




char *ctermid(char *);





FILE *fdopen(int, const char *) __asm("_" "fdopen" );

int fileno(FILE *);

# 318 "/usr/include/stdio.h" 3 4

int pclose(FILE *);



FILE *popen(const char *, const char *) __asm("_" "popen" );


# 340 "/usr/include/stdio.h" 3 4

int __srget(FILE *);
int __svfscanf(FILE *, const char *, va_list) __attribute__((__format__ (__scanf__, 2, 0)));
int __swbuf(int, FILE *);








static __inline int __sputc(int _c, FILE *_p) {
 if (--_p->_w >= 0 || (_p->_w >= _p->_lbfsize && (char)_c != '\n'))
  return (*_p->_p++ = _c);
 else
  return (__swbuf(_c, _p));
}
# 377 "/usr/include/stdio.h" 3 4

void flockfile(FILE *);
int ftrylockfile(FILE *);
void funlockfile(FILE *);
int getc_unlocked(FILE *);
int getchar_unlocked(void);
int putc_unlocked(int, FILE *);
int putchar_unlocked(int);



int getw(FILE *);
int putw(int, FILE *);


char *tempnam(const char *, const char *) __asm("_" "tempnam" );

# 417 "/usr/include/stdio.h" 3 4

int fseeko(FILE *, off_t, int);
off_t ftello(FILE *);





int snprintf(char * , size_t, const char * , ...) __attribute__((__format__ (__printf__, 3, 4)));
int vfscanf(FILE * , const char * , va_list) __attribute__((__format__ (__scanf__, 2, 0)));
int vscanf(const char * , va_list) __attribute__((__format__ (__scanf__, 1, 0)));
int vsnprintf(char * , size_t, const char * , va_list) __attribute__((__format__ (__printf__, 3, 0)));
int vsscanf(const char * , const char * , va_list) __attribute__((__format__ (__scanf__, 2, 0)));

# 445 "/usr/include/stdio.h" 3 4

int dprintf(int, const char * , ...) __attribute__((__format__ (__printf__, 2, 3))) __attribute__((visibility("default")));
int vdprintf(int, const char * , va_list) __attribute__((__format__ (__printf__, 2, 0))) __attribute__((visibility("default")));
ssize_t getdelim(char ** , size_t * , int, FILE * ) __attribute__((visibility("default")));
ssize_t getline(char ** , size_t * , FILE * ) __attribute__((visibility("default")));









extern const int sys_nerr;
extern const char *const sys_errlist[];

int asprintf(char **, const char *, ...) __attribute__((__format__ (__printf__, 2, 3)));
char *ctermid_r(char *);
char *fgetln(FILE *, size_t *);
const char *fmtcheck(const char *, const char *);
int fpurge(FILE *);
void setbuffer(FILE *, char *, int);
int setlinebuf(FILE *);
int vasprintf(char **, const char *, va_list) __attribute__((__format__ (__printf__, 2, 0)));
FILE *zopen(const char *, const char *, int);





FILE *funopen(const void *,
                 int (*)(void *, char *, int),
                 int (*)(void *, const char *, int),
                 fpos_t (*)(void *, fpos_t, int),
                 int (*)(void *));

# 499 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/secure/_stdio.h" 1 3 4
# 31 "/usr/include/secure/_stdio.h" 3 4
# 1 "/usr/include/secure/_common.h" 1 3 4
# 32 "/usr/include/secure/_stdio.h" 2 3 4
# 45 "/usr/include/secure/_stdio.h" 3 4
extern int __sprintf_chk (char * , int, size_t,
     const char * , ...);




extern int __snprintf_chk (char * , size_t, int, size_t,
      const char * , ...);





extern int __vsprintf_chk (char * , int, size_t,
      const char * , va_list);




extern int __vsnprintf_chk (char * , size_t, int, size_t,
       const char * , va_list);
# 500 "/usr/include/stdio.h" 2 3 4
# 23 "H5Epublic.h" 2
# 32 "H5Epublic.h"
typedef enum H5E_type_t {
    H5E_MAJOR,
    H5E_MINOR
} H5E_type_t;


typedef struct H5E_error2_t {
    hid_t cls_id;
    hid_t maj_num;
    hid_t min_num;
    unsigned line;
    const char *func_name;
    const char *file_name;
    const char *desc;
} H5E_error2_t;
# 58 "H5Epublic.h"
extern hid_t H5E_ERR_CLS_g;



# 1 "H5Epubgen.h" 1
# 58 "H5Epubgen.h"
extern hid_t H5E_DATASET_g;
extern hid_t H5E_FUNC_g;
extern hid_t H5E_STORAGE_g;
extern hid_t H5E_FILE_g;
extern hid_t H5E_SOHM_g;
extern hid_t H5E_SYM_g;
extern hid_t H5E_PLUGIN_g;
extern hid_t H5E_VFL_g;
extern hid_t H5E_INTERNAL_g;
extern hid_t H5E_BTREE_g;
extern hid_t H5E_REFERENCE_g;
extern hid_t H5E_DATASPACE_g;
extern hid_t H5E_RESOURCE_g;
extern hid_t H5E_PLIST_g;
extern hid_t H5E_LINK_g;
extern hid_t H5E_DATATYPE_g;
extern hid_t H5E_RS_g;
extern hid_t H5E_HEAP_g;
extern hid_t H5E_OHDR_g;
extern hid_t H5E_ATOM_g;
extern hid_t H5E_ATTR_g;
extern hid_t H5E_NONE_MAJOR_g;
extern hid_t H5E_IO_g;
extern hid_t H5E_SLIST_g;
extern hid_t H5E_EFL_g;
extern hid_t H5E_TST_g;
extern hid_t H5E_ARGS_g;
extern hid_t H5E_ERROR_g;
extern hid_t H5E_PLINE_g;
extern hid_t H5E_FSPACE_g;
extern hid_t H5E_CACHE_g;
# 101 "H5Epubgen.h"
extern hid_t H5E_SEEKERROR_g;
extern hid_t H5E_READERROR_g;
extern hid_t H5E_WRITEERROR_g;
extern hid_t H5E_CLOSEERROR_g;
extern hid_t H5E_OVERFLOW_g;
extern hid_t H5E_FCNTL_g;
# 119 "H5Epubgen.h"
extern hid_t H5E_NOSPACE_g;
extern hid_t H5E_CANTALLOC_g;
extern hid_t H5E_CANTCOPY_g;
extern hid_t H5E_CANTFREE_g;
extern hid_t H5E_ALREADYEXISTS_g;
extern hid_t H5E_CANTLOCK_g;
extern hid_t H5E_CANTUNLOCK_g;
extern hid_t H5E_CANTGC_g;
extern hid_t H5E_CANTGETSIZE_g;
extern hid_t H5E_OBJOPEN_g;
# 137 "H5Epubgen.h"
extern hid_t H5E_CANTRESTORE_g;
extern hid_t H5E_CANTCOMPUTE_g;
extern hid_t H5E_CANTEXTEND_g;
extern hid_t H5E_CANTATTACH_g;
extern hid_t H5E_CANTUPDATE_g;
extern hid_t H5E_CANTOPERATE_g;





extern hid_t H5E_CANTINIT_g;
extern hid_t H5E_ALREADYINIT_g;
extern hid_t H5E_CANTRELEASE_g;






extern hid_t H5E_CANTGET_g;
extern hid_t H5E_CANTSET_g;
extern hid_t H5E_DUPCLASS_g;
extern hid_t H5E_SETDISALLOWED_g;





extern hid_t H5E_CANTMERGE_g;
extern hid_t H5E_CANTREVIVE_g;
extern hid_t H5E_CANTSHRINK_g;
# 180 "H5Epubgen.h"
extern hid_t H5E_LINKCOUNT_g;
extern hid_t H5E_VERSION_g;
extern hid_t H5E_ALIGNMENT_g;
extern hid_t H5E_BADMESG_g;
extern hid_t H5E_CANTDELETE_g;
extern hid_t H5E_BADITER_g;
extern hid_t H5E_CANTPACK_g;
extern hid_t H5E_CANTRESET_g;
extern hid_t H5E_CANTRENAME_g;



extern hid_t H5E_SYSERRSTR_g;
# 201 "H5Epubgen.h"
extern hid_t H5E_NOFILTER_g;
extern hid_t H5E_CALLBACK_g;
extern hid_t H5E_CANAPPLY_g;
extern hid_t H5E_SETLOCAL_g;
extern hid_t H5E_NOENCODER_g;
extern hid_t H5E_CANTFILTER_g;






extern hid_t H5E_CANTOPENOBJ_g;
extern hid_t H5E_CANTCLOSEOBJ_g;
extern hid_t H5E_COMPLEN_g;
extern hid_t H5E_PATH_g;



extern hid_t H5E_NONE_MINOR_g;



extern hid_t H5E_OPENERROR_g;
# 236 "H5Epubgen.h"
extern hid_t H5E_FILEEXISTS_g;
extern hid_t H5E_FILEOPEN_g;
extern hid_t H5E_CANTCREATE_g;
extern hid_t H5E_CANTOPENFILE_g;
extern hid_t H5E_CANTCLOSEFILE_g;
extern hid_t H5E_NOTHDF5_g;
extern hid_t H5E_BADFILE_g;
extern hid_t H5E_TRUNCATED_g;
extern hid_t H5E_MOUNT_g;
# 253 "H5Epubgen.h"
extern hid_t H5E_BADATOM_g;
extern hid_t H5E_BADGROUP_g;
extern hid_t H5E_CANTREGISTER_g;
extern hid_t H5E_CANTINC_g;
extern hid_t H5E_CANTDEC_g;
extern hid_t H5E_NOIDS_g;
# 276 "H5Epubgen.h"
extern hid_t H5E_CANTFLUSH_g;
extern hid_t H5E_CANTSERIALIZE_g;
extern hid_t H5E_CANTLOAD_g;
extern hid_t H5E_PROTECT_g;
extern hid_t H5E_NOTCACHED_g;
extern hid_t H5E_SYSTEM_g;
extern hid_t H5E_CANTINS_g;
extern hid_t H5E_CANTPROTECT_g;
extern hid_t H5E_CANTUNPROTECT_g;
extern hid_t H5E_CANTPIN_g;
extern hid_t H5E_CANTUNPIN_g;
extern hid_t H5E_CANTMARKDIRTY_g;
extern hid_t H5E_CANTDIRTY_g;
extern hid_t H5E_CANTEXPUNGE_g;
extern hid_t H5E_CANTRESIZE_g;







extern hid_t H5E_TRAVERSE_g;
extern hid_t H5E_NLINKS_g;
extern hid_t H5E_NOTREGISTERED_g;
extern hid_t H5E_CANTMOVE_g;
extern hid_t H5E_CANTSORT_g;





extern hid_t H5E_MPI_g;
extern hid_t H5E_MPIERRSTR_g;
extern hid_t H5E_CANTRECV_g;
# 319 "H5Epubgen.h"
extern hid_t H5E_CANTCLIP_g;
extern hid_t H5E_CANTCOUNT_g;
extern hid_t H5E_CANTSELECT_g;
extern hid_t H5E_CANTNEXT_g;
extern hid_t H5E_BADSELECT_g;
extern hid_t H5E_CANTCOMPARE_g;







extern hid_t H5E_UNINITIALIZED_g;
extern hid_t H5E_UNSUPPORTED_g;
extern hid_t H5E_BADTYPE_g;
extern hid_t H5E_BADRANGE_g;
extern hid_t H5E_BADVALUE_g;
# 350 "H5Epubgen.h"
extern hid_t H5E_NOTFOUND_g;
extern hid_t H5E_EXISTS_g;
extern hid_t H5E_CANTENCODE_g;
extern hid_t H5E_CANTDECODE_g;
extern hid_t H5E_CANTSPLIT_g;
extern hid_t H5E_CANTREDISTRIBUTE_g;
extern hid_t H5E_CANTSWAP_g;
extern hid_t H5E_CANTINSERT_g;
extern hid_t H5E_CANTLIST_g;
extern hid_t H5E_CANTMODIFY_g;
extern hid_t H5E_CANTREMOVE_g;




extern hid_t H5E_CANTCONVERT_g;
extern hid_t H5E_BADSIZE_g;
# 63 "H5Epublic.h" 2
# 141 "H5Epublic.h"
typedef enum H5E_direction_t {
    H5E_WALK_UPWARD = 0,
    H5E_WALK_DOWNWARD = 1
} H5E_direction_t;







typedef herr_t (*H5E_walk2_t)(unsigned n, const H5E_error2_t *err_desc,
    void *client_data);
typedef herr_t (*H5E_auto2_t)(hid_t estack, void *client_data);


 hid_t H5Eregister_class(const char *cls_name, const char *lib_name,
    const char *version);
 herr_t H5Eunregister_class(hid_t class_id);
 herr_t H5Eclose_msg(hid_t err_id);
 hid_t H5Ecreate_msg(hid_t cls, H5E_type_t msg_type, const char *msg);
 hid_t H5Ecreate_stack(void);
 hid_t H5Eget_current_stack(void);
 herr_t H5Eclose_stack(hid_t stack_id);
 ssize_t H5Eget_class_name(hid_t class_id, char *name, size_t size);
 herr_t H5Eset_current_stack(hid_t err_stack_id);
 herr_t H5Epush2(hid_t err_stack, const char *file, const char *func, unsigned line,
    hid_t cls_id, hid_t maj_id, hid_t min_id, const char *msg, ...);
 herr_t H5Epop(hid_t err_stack, size_t count);
 herr_t H5Eprint2(hid_t err_stack, FILE *stream);
 herr_t H5Ewalk2(hid_t err_stack, H5E_direction_t direction, H5E_walk2_t func,
    void *client_data);
 herr_t H5Eget_auto2(hid_t estack_id, H5E_auto2_t *func, void **client_data);
 herr_t H5Eset_auto2(hid_t estack_id, H5E_auto2_t func, void *client_data);
 herr_t H5Eclear2(hid_t err_stack);
 herr_t H5Eauto_is_v2(hid_t err_stack, unsigned *is_stack);
 ssize_t H5Eget_msg(hid_t msg_id, H5E_type_t *type, char *msg,
    size_t size);
 ssize_t H5Eget_num(hid_t error_stack_id);
# 193 "H5Epublic.h"
typedef hid_t H5E_major_t;
typedef hid_t H5E_minor_t;


typedef struct H5E_error1_t {
    H5E_major_t maj_num;
    H5E_minor_t min_num;
    const char *func_name;
    const char *file_name;
    unsigned line;
    const char *desc;
} H5E_error1_t;


typedef herr_t (*H5E_walk1_t)(int n, H5E_error1_t *err_desc, void *client_data);
typedef herr_t (*H5E_auto1_t)(void *client_data);


 herr_t H5Eclear1(void);
 herr_t H5Eget_auto1(H5E_auto1_t *func, void **client_data);
 herr_t H5Epush1(const char *file, const char *func, unsigned line,
    H5E_major_t maj, H5E_minor_t min, const char *str);
 herr_t H5Eprint1(FILE *stream);
 herr_t H5Eset_auto1(H5E_auto1_t func, void *client_data);
 herr_t H5Ewalk1(H5E_direction_t direction, H5E_walk1_t func,
    void *client_data);
 char *H5Eget_major(H5E_major_t maj);
 char *H5Eget_minor(H5E_minor_t min);
# 29 "hdf5.h" 2
# 1 "H5Fpublic.h" 1
# 79 "H5Fpublic.h"
typedef enum H5F_scope_t {
    H5F_SCOPE_LOCAL = 0,
    H5F_SCOPE_GLOBAL = 1
} H5F_scope_t;
# 95 "H5Fpublic.h"
typedef enum H5F_close_degree_t {
    H5F_CLOSE_DEFAULT = 0,
    H5F_CLOSE_WEAK = 1,
    H5F_CLOSE_SEMI = 2,
    H5F_CLOSE_STRONG = 3
} H5F_close_degree_t;



typedef struct H5F_info_t {
    hsize_t super_ext_size;
    struct {
 hsize_t hdr_size;
 H5_ih_info_t msgs_info;
    } sohm;
} H5F_info_t;
# 120 "H5Fpublic.h"
typedef enum H5F_mem_t {
    H5FD_MEM_NOLIST = -1,


    H5FD_MEM_DEFAULT = 0,




    H5FD_MEM_SUPER = 1,
    H5FD_MEM_BTREE = 2,
    H5FD_MEM_DRAW = 3,
    H5FD_MEM_GHEAP = 4,
    H5FD_MEM_LHEAP = 5,
    H5FD_MEM_OHDR = 6,

    H5FD_MEM_NTYPES
} H5F_mem_t;


typedef enum H5F_libver_t {
    H5F_LIBVER_EARLIEST,
    H5F_LIBVER_LATEST
} H5F_libver_t;
# 154 "H5Fpublic.h"
 htri_t H5Fis_hdf5(const char *filename);
 hid_t H5Fcreate(const char *filename, unsigned flags,
       hid_t create_plist, hid_t access_plist);
 hid_t H5Fopen(const char *filename, unsigned flags,
          hid_t access_plist);
 hid_t H5Freopen(hid_t file_id);
 herr_t H5Fflush(hid_t object_id, H5F_scope_t scope);
 herr_t H5Fclose(hid_t file_id);
 hid_t H5Fget_create_plist(hid_t file_id);
 hid_t H5Fget_access_plist(hid_t file_id);
 herr_t H5Fget_intent(hid_t file_id, unsigned * intent);
 ssize_t H5Fget_obj_count(hid_t file_id, unsigned types);
 ssize_t H5Fget_obj_ids(hid_t file_id, unsigned types, size_t max_objs, hid_t *obj_id_list);
 herr_t H5Fget_vfd_handle(hid_t file_id, hid_t fapl, void **file_handle);
 herr_t H5Fmount(hid_t loc, const char *name, hid_t child, hid_t plist);
 herr_t H5Funmount(hid_t loc, const char *name);
 hssize_t H5Fget_freespace(hid_t file_id);
 herr_t H5Fget_filesize(hid_t file_id, hsize_t *size);
 ssize_t H5Fget_file_image(hid_t file_id, void * buf_ptr, size_t buf_len);
 herr_t H5Fget_mdc_config(hid_t file_id,
    H5AC_cache_config_t * config_ptr);
 herr_t H5Fset_mdc_config(hid_t file_id,
    H5AC_cache_config_t * config_ptr);
 herr_t H5Fget_mdc_hit_rate(hid_t file_id, double * hit_rate_ptr);
 herr_t H5Fget_mdc_size(hid_t file_id,
                              size_t * max_size_ptr,
                              size_t * min_clean_size_ptr,
                              size_t * cur_size_ptr,
                              int * cur_num_entries_ptr);
 herr_t H5Freset_mdc_hit_rate_stats(hid_t file_id);
 ssize_t H5Fget_name(hid_t obj_id, char *name, size_t size);
 herr_t H5Fget_info(hid_t obj_id, H5F_info_t *bh_info);
 herr_t H5Fclear_elink_file_cache(hid_t file_id);
# 30 "hdf5.h" 2
# 1 "H5FDpublic.h" 1
# 30 "H5FDpublic.h"
typedef enum H5F_mem_t H5FD_mem_t;
# 195 "H5FDpublic.h"
typedef struct H5FD_t H5FD_t;


typedef struct H5FD_class_t {
    const char *name;
    haddr_t maxaddr;
    H5F_close_degree_t fc_degree;
    hsize_t (*sb_size)(H5FD_t *file);
    herr_t (*sb_encode)(H5FD_t *file, char *name ,
                         unsigned char *p );
    herr_t (*sb_decode)(H5FD_t *f, const char *name, const unsigned char *p);
    size_t fapl_size;
    void * (*fapl_get)(H5FD_t *file);
    void * (*fapl_copy)(const void *fapl);
    herr_t (*fapl_free)(void *fapl);
    size_t dxpl_size;
    void * (*dxpl_copy)(const void *dxpl);
    herr_t (*dxpl_free)(void *dxpl);
    H5FD_t *(*open)(const char *name, unsigned flags, hid_t fapl,
                    haddr_t maxaddr);
    herr_t (*close)(H5FD_t *file);
    int (*cmp)(const H5FD_t *f1, const H5FD_t *f2);
    herr_t (*query)(const H5FD_t *f1, unsigned long *flags);
    herr_t (*get_type_map)(const H5FD_t *file, H5FD_mem_t *type_map);
    haddr_t (*alloc)(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id, hsize_t size);
    herr_t (*free)(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
                    haddr_t addr, hsize_t size);
    haddr_t (*get_eoa)(const H5FD_t *file, H5FD_mem_t type);
    herr_t (*set_eoa)(H5FD_t *file, H5FD_mem_t type, haddr_t addr);
    haddr_t (*get_eof)(const H5FD_t *file);
    herr_t (*get_handle)(H5FD_t *file, hid_t fapl, void**file_handle);
    herr_t (*read)(H5FD_t *file, H5FD_mem_t type, hid_t dxpl,
                    haddr_t addr, size_t size, void *buffer);
    herr_t (*write)(H5FD_t *file, H5FD_mem_t type, hid_t dxpl,
                     haddr_t addr, size_t size, const void *buffer);
    herr_t (*flush)(H5FD_t *file, hid_t dxpl_id, unsigned closing);
    herr_t (*truncate)(H5FD_t *file, hid_t dxpl_id, hbool_t closing);
    herr_t (*lock)(H5FD_t *file, unsigned char *oid, unsigned lock_type, hbool_t last);
    herr_t (*unlock)(H5FD_t *file, unsigned char *oid, hbool_t last);
    H5FD_mem_t fl_map[H5FD_MEM_NTYPES];
} H5FD_class_t;


typedef struct H5FD_free_t {
    haddr_t addr;
    hsize_t size;
    struct H5FD_free_t *next;
} H5FD_free_t;





struct H5FD_t {
    hid_t driver_id;
    const H5FD_class_t *cls;
    unsigned long fileno;
    unsigned long feature_flags;
    haddr_t maxaddr;
    haddr_t base_addr;


    hsize_t threshold;
    hsize_t alignment;
};


typedef enum {
    H5FD_FILE_IMAGE_OP_NO_OP,
    H5FD_FILE_IMAGE_OP_PROPERTY_LIST_SET,
    H5FD_FILE_IMAGE_OP_PROPERTY_LIST_COPY,
    H5FD_FILE_IMAGE_OP_PROPERTY_LIST_GET,
    H5FD_FILE_IMAGE_OP_PROPERTY_LIST_CLOSE,
    H5FD_FILE_IMAGE_OP_FILE_OPEN,
    H5FD_FILE_IMAGE_OP_FILE_RESIZE,
    H5FD_FILE_IMAGE_OP_FILE_CLOSE
} H5FD_file_image_op_t;


typedef struct {
    void *(*image_malloc)(size_t size, H5FD_file_image_op_t file_image_op,
                            void *udata);
    void *(*image_memcpy)(void *dest, const void *src, size_t size,
                            H5FD_file_image_op_t file_image_op, void *udata);
    void *(*image_realloc)(void *ptr, size_t size,
                            H5FD_file_image_op_t file_image_op, void *udata);
    herr_t (*image_free)(void *ptr, H5FD_file_image_op_t file_image_op,
                          void *udata);
    void *(*udata_copy)(void *udata);
    herr_t (*udata_free)(void *udata);
    void *udata;
} H5FD_file_image_callbacks_t;






 hid_t H5FDregister(const H5FD_class_t *cls);
 herr_t H5FDunregister(hid_t driver_id);
 H5FD_t *H5FDopen(const char *name, unsigned flags, hid_t fapl_id,
                        haddr_t maxaddr);
 herr_t H5FDclose(H5FD_t *file);
 int H5FDcmp(const H5FD_t *f1, const H5FD_t *f2);
 int H5FDquery(const H5FD_t *f, unsigned long *flags);
 haddr_t H5FDalloc(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id, hsize_t size);
 herr_t H5FDfree(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
                       haddr_t addr, hsize_t size);
 haddr_t H5FDget_eoa(H5FD_t *file, H5FD_mem_t type);
 herr_t H5FDset_eoa(H5FD_t *file, H5FD_mem_t type, haddr_t eoa);
 haddr_t H5FDget_eof(H5FD_t *file);
 herr_t H5FDget_vfd_handle(H5FD_t *file, hid_t fapl, void**file_handle);
 herr_t H5FDread(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
                       haddr_t addr, size_t size, void *buf );
 herr_t H5FDwrite(H5FD_t *file, H5FD_mem_t type, hid_t dxpl_id,
                        haddr_t addr, size_t size, const void *buf);
 herr_t H5FDflush(H5FD_t *file, hid_t dxpl_id, unsigned closing);
 herr_t H5FDtruncate(H5FD_t *file, hid_t dxpl_id, hbool_t closing);
# 31 "hdf5.h" 2
# 1 "H5Gpublic.h" 1
# 51 "H5Gpublic.h"
typedef enum H5G_storage_type_t {
    H5G_STORAGE_TYPE_UNKNOWN = -1,
    H5G_STORAGE_TYPE_SYMBOL_TABLE,

    H5G_STORAGE_TYPE_COMPACT,
    H5G_STORAGE_TYPE_DENSE
} H5G_storage_type_t;


typedef struct H5G_info_t {
    H5G_storage_type_t storage_type;
    hsize_t nlinks;
    int64_t max_corder;
    hbool_t mounted;
} H5G_info_t;
# 75 "H5Gpublic.h"
 hid_t H5Gcreate2(hid_t loc_id, const char *name, hid_t lcpl_id,
    hid_t gcpl_id, hid_t gapl_id);
 hid_t H5Gcreate_anon(hid_t loc_id, hid_t gcpl_id, hid_t gapl_id);
 hid_t H5Gopen2(hid_t loc_id, const char *name, hid_t gapl_id);
 hid_t H5Gget_create_plist(hid_t group_id);
 herr_t H5Gget_info(hid_t loc_id, H5G_info_t *ginfo);
 herr_t H5Gget_info_by_name(hid_t loc_id, const char *name, H5G_info_t *ginfo,
    hid_t lapl_id);
 herr_t H5Gget_info_by_idx(hid_t loc_id, const char *group_name,
    H5_index_t idx_type, H5_iter_order_t order, hsize_t n, H5G_info_t *ginfo,
    hid_t lapl_id);
 herr_t H5Gclose(hid_t group_id);
# 119 "H5Gpublic.h"
typedef enum H5G_obj_t {
    H5G_UNKNOWN = -1,
    H5G_GROUP,
    H5G_DATASET,
    H5G_TYPE,
    H5G_LINK,
    H5G_UDLINK,
    H5G_RESERVED_5,
    H5G_RESERVED_6,
    H5G_RESERVED_7
} H5G_obj_t;


typedef herr_t (*H5G_iterate_t)(hid_t group, const char *name, void *op_data);


typedef struct H5G_stat_t {
    unsigned long fileno[2];
    unsigned long objno[2];
    unsigned nlink;
    H5G_obj_t type;
    time_t mtime;
    size_t linklen;
    H5O_stat_t ohdr;
} H5G_stat_t;



 hid_t H5Gcreate1(hid_t loc_id, const char *name, size_t size_hint);
 hid_t H5Gopen1(hid_t loc_id, const char *name);
 herr_t H5Glink(hid_t cur_loc_id, H5L_type_t type, const char *cur_name,
    const char *new_name);
 herr_t H5Glink2(hid_t cur_loc_id, const char *cur_name, H5L_type_t type,
    hid_t new_loc_id, const char *new_name);
 herr_t H5Gmove(hid_t src_loc_id, const char *src_name,
    const char *dst_name);
 herr_t H5Gmove2(hid_t src_loc_id, const char *src_name, hid_t dst_loc_id,
    const char *dst_name);
 herr_t H5Gunlink(hid_t loc_id, const char *name);
 herr_t H5Gget_linkval(hid_t loc_id, const char *name, size_t size,
    char *buf );
 herr_t H5Gset_comment(hid_t loc_id, const char *name, const char *comment);
 int H5Gget_comment(hid_t loc_id, const char *name, size_t bufsize,
    char *buf);
 herr_t H5Giterate(hid_t loc_id, const char *name, int *idx,
        H5G_iterate_t op, void *op_data);
 herr_t H5Gget_num_objs(hid_t loc_id, hsize_t *num_objs);
 herr_t H5Gget_objinfo(hid_t loc_id, const char *name,
    hbool_t follow_link, H5G_stat_t *statbuf );
 ssize_t H5Gget_objname_by_idx(hid_t loc_id, hsize_t idx, char* name,
    size_t size);
 H5G_obj_t H5Gget_objtype_by_idx(hid_t loc_id, hsize_t idx);
# 32 "hdf5.h" 2


# 1 "H5MMpublic.h" 1
# 36 "H5MMpublic.h"
typedef void *(*H5MM_allocate_t)(size_t size, void *alloc_info);
typedef void (*H5MM_free_t)(void *mem, void *free_info);
# 35 "hdf5.h" 2

# 1 "H5Ppublic.h" 1
# 36 "H5Ppublic.h"
# 1 "H5Zpublic.h" 1
# 33 "H5Zpublic.h"
typedef int H5Z_filter_t;
# 99 "H5Zpublic.h"
typedef enum H5Z_SO_scale_type_t {
    H5Z_SO_FLOAT_DSCALE = 0,
    H5Z_SO_FLOAT_ESCALE = 1,
    H5Z_SO_INT = 2
} H5Z_SO_scale_type_t;





typedef enum H5Z_EDC_t {
    H5Z_ERROR_EDC = -1,
    H5Z_DISABLE_EDC = 0,
    H5Z_ENABLE_EDC = 1,
    H5Z_NO_EDC = 2
} H5Z_EDC_t;






typedef enum H5Z_cb_return_t {
    H5Z_CB_ERROR = -1,
    H5Z_CB_FAIL = 0,
    H5Z_CB_CONT = 1,
    H5Z_CB_NO = 2
} H5Z_cb_return_t;


typedef H5Z_cb_return_t (*H5Z_filter_func_t)(H5Z_filter_t filter, void* buf,
                                size_t buf_size, void* op_data);


typedef struct H5Z_cb_t {
    H5Z_filter_func_t func;
    void* op_data;
} H5Z_cb_t;
# 162 "H5Zpublic.h"
typedef htri_t (*H5Z_can_apply_func_t)(hid_t dcpl_id, hid_t type_id, hid_t space_id);
# 185 "H5Zpublic.h"
typedef herr_t (*H5Z_set_local_func_t)(hid_t dcpl_id, hid_t type_id, hid_t space_id);
# 202 "H5Zpublic.h"
typedef size_t (*H5Z_func_t)(unsigned int flags, size_t cd_nelmts,
        const unsigned int cd_values[], size_t nbytes,
        size_t *buf_size, void **buf);





typedef struct H5Z_class2_t {
    int version;
    H5Z_filter_t id;
    unsigned encoder_present;
    unsigned decoder_present;
    const char *name;
    H5Z_can_apply_func_t can_apply;
    H5Z_set_local_func_t set_local;
    H5Z_func_t filter;
} H5Z_class2_t;

 herr_t H5Zregister(const void *cls);
 herr_t H5Zunregister(H5Z_filter_t id);
 htri_t H5Zfilter_avail(H5Z_filter_t id);
 herr_t H5Zget_filter_info(H5Z_filter_t filter, unsigned int *filter_config_flags);
# 236 "H5Zpublic.h"
typedef struct H5Z_class1_t {
    H5Z_filter_t id;
    const char *name;
    H5Z_can_apply_func_t can_apply;
    H5Z_set_local_func_t set_local;
    H5Z_func_t filter;
} H5Z_class1_t;
# 37 "H5Ppublic.h" 2
# 105 "H5Ppublic.h"
typedef herr_t (*H5P_cls_create_func_t)(hid_t prop_id, void *create_data);
typedef herr_t (*H5P_cls_copy_func_t)(hid_t new_prop_id, hid_t old_prop_id,
                                      void *copy_data);
typedef herr_t (*H5P_cls_close_func_t)(hid_t prop_id, void *close_data);


typedef herr_t (*H5P_prp_cb1_t)(const char *name, size_t size, void *value);
typedef herr_t (*H5P_prp_cb2_t)(hid_t prop_id, const char *name, size_t size, void *value);
typedef H5P_prp_cb1_t H5P_prp_create_func_t;
typedef H5P_prp_cb2_t H5P_prp_set_func_t;
typedef H5P_prp_cb2_t H5P_prp_get_func_t;
typedef H5P_prp_cb2_t H5P_prp_delete_func_t;
typedef H5P_prp_cb1_t H5P_prp_copy_func_t;
typedef int (*H5P_prp_compare_func_t)(const void *value1, const void *value2, size_t size);
typedef H5P_prp_cb1_t H5P_prp_close_func_t;


typedef herr_t (*H5P_iterate_t)(hid_t id, const char *name, void *iter_data);


typedef enum H5D_mpio_actual_chunk_opt_mode_t {




    H5D_MPIO_NO_CHUNK_OPTIMIZATION = 0,
    H5D_MPIO_LINK_CHUNK,
    H5D_MPIO_MULTI_CHUNK
} H5D_mpio_actual_chunk_opt_mode_t;

typedef enum H5D_mpio_actual_io_mode_t {
# 146 "H5Ppublic.h"
    H5D_MPIO_NO_COLLECTIVE = 0x0,
    H5D_MPIO_CHUNK_INDEPENDENT = 0x1,
    H5D_MPIO_CHUNK_COLLECTIVE = 0x2,
    H5D_MPIO_CHUNK_MIXED = 0x1 | 0x2,


    H5D_MPIO_CONTIGUOUS_COLLECTIVE = 0x4
} H5D_mpio_actual_io_mode_t;


typedef enum H5D_mpio_no_collective_cause_t {
    H5D_MPIO_COLLECTIVE = 0x00,
    H5D_MPIO_SET_INDEPENDENT = 0x01,
    H5D_MPIO_DATATYPE_CONVERSION = 0x02,
    H5D_MPIO_DATA_TRANSFORMS = 0x04,
    H5D_MPIO_SET_MPIPOSIX = 0x08,
    H5D_MPIO_NOT_SIMPLE_OR_SCALAR_DATASPACES = 0x10,
    H5D_MPIO_POINT_SELECTIONS = 0x20,
    H5D_MPIO_NOT_CONTIGUOUS_OR_CHUNKED_DATASET = 0x40,
    H5D_MPIO_FILTERS = 0x80
} H5D_mpio_no_collective_cause_t;







extern hid_t H5P_CLS_ROOT_g;
extern hid_t H5P_CLS_OBJECT_CREATE_g;
extern hid_t H5P_CLS_FILE_CREATE_g;
extern hid_t H5P_CLS_FILE_ACCESS_g;
extern hid_t H5P_CLS_DATASET_CREATE_g;
extern hid_t H5P_CLS_DATASET_ACCESS_g;
extern hid_t H5P_CLS_DATASET_XFER_g;
extern hid_t H5P_CLS_FILE_MOUNT_g;
extern hid_t H5P_CLS_GROUP_CREATE_g;
extern hid_t H5P_CLS_GROUP_ACCESS_g;
extern hid_t H5P_CLS_DATATYPE_CREATE_g;
extern hid_t H5P_CLS_DATATYPE_ACCESS_g;
extern hid_t H5P_CLS_STRING_CREATE_g;
extern hid_t H5P_CLS_ATTRIBUTE_CREATE_g;
extern hid_t H5P_CLS_OBJECT_COPY_g;
extern hid_t H5P_CLS_LINK_CREATE_g;
extern hid_t H5P_CLS_LINK_ACCESS_g;



extern hid_t H5P_LST_FILE_CREATE_g;
extern hid_t H5P_LST_FILE_ACCESS_g;
extern hid_t H5P_LST_DATASET_CREATE_g;
extern hid_t H5P_LST_DATASET_ACCESS_g;
extern hid_t H5P_LST_DATASET_XFER_g;
extern hid_t H5P_LST_FILE_MOUNT_g;
extern hid_t H5P_LST_GROUP_CREATE_g;
extern hid_t H5P_LST_GROUP_ACCESS_g;
extern hid_t H5P_LST_DATATYPE_CREATE_g;
extern hid_t H5P_LST_DATATYPE_ACCESS_g;
extern hid_t H5P_LST_ATTRIBUTE_CREATE_g;
extern hid_t H5P_LST_OBJECT_COPY_g;
extern hid_t H5P_LST_LINK_CREATE_g;
extern hid_t H5P_LST_LINK_ACCESS_g;






 hid_t H5Pcreate_class(hid_t parent, const char *name,
    H5P_cls_create_func_t cls_create, void *create_data,
    H5P_cls_copy_func_t cls_copy, void *copy_data,
    H5P_cls_close_func_t cls_close, void *close_data);
 char *H5Pget_class_name(hid_t pclass_id);
 hid_t H5Pcreate(hid_t cls_id);
 herr_t H5Pregister2(hid_t cls_id, const char *name, size_t size,
    void *def_value, H5P_prp_create_func_t prp_create,
    H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
    H5P_prp_delete_func_t prp_del, H5P_prp_copy_func_t prp_copy,
    H5P_prp_compare_func_t prp_cmp, H5P_prp_close_func_t prp_close);
 herr_t H5Pinsert2(hid_t plist_id, const char *name, size_t size,
    void *value, H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
    H5P_prp_delete_func_t prp_delete, H5P_prp_copy_func_t prp_copy,
    H5P_prp_compare_func_t prp_cmp, H5P_prp_close_func_t prp_close);
 herr_t H5Pset(hid_t plist_id, const char *name, void *value);
 htri_t H5Pexist(hid_t plist_id, const char *name);
 herr_t H5Pget_size(hid_t id, const char *name, size_t *size);
 herr_t H5Pget_nprops(hid_t id, size_t *nprops);
 hid_t H5Pget_class(hid_t plist_id);
 hid_t H5Pget_class_parent(hid_t pclass_id);
 herr_t H5Pget(hid_t plist_id, const char *name, void * value);
 htri_t H5Pequal(hid_t id1, hid_t id2);
 htri_t H5Pisa_class(hid_t plist_id, hid_t pclass_id);
 int H5Piterate(hid_t id, int *idx, H5P_iterate_t iter_func,
            void *iter_data);
 herr_t H5Pcopy_prop(hid_t dst_id, hid_t src_id, const char *name);
 herr_t H5Premove(hid_t plist_id, const char *name);
 herr_t H5Punregister(hid_t pclass_id, const char *name);
 herr_t H5Pclose_class(hid_t plist_id);
 herr_t H5Pclose(hid_t plist_id);
 hid_t H5Pcopy(hid_t plist_id);


 herr_t H5Pset_attr_phase_change(hid_t plist_id, unsigned max_compact, unsigned min_dense);
 herr_t H5Pget_attr_phase_change(hid_t plist_id, unsigned *max_compact, unsigned *min_dense);
 herr_t H5Pset_attr_creation_order(hid_t plist_id, unsigned crt_order_flags);
 herr_t H5Pget_attr_creation_order(hid_t plist_id, unsigned *crt_order_flags);
 herr_t H5Pset_obj_track_times(hid_t plist_id, hbool_t track_times);
 herr_t H5Pget_obj_track_times(hid_t plist_id, hbool_t *track_times);
 herr_t H5Pmodify_filter(hid_t plist_id, H5Z_filter_t filter,
        unsigned int flags, size_t cd_nelmts,
        const unsigned int cd_values[ ]);
 herr_t H5Pset_filter(hid_t plist_id, H5Z_filter_t filter,
        unsigned int flags, size_t cd_nelmts,
        const unsigned int c_values[]);
 int H5Pget_nfilters(hid_t plist_id);
 H5Z_filter_t H5Pget_filter2(hid_t plist_id, unsigned filter,
       unsigned int *flags ,
       size_t *cd_nelmts ,
       unsigned cd_values[] ,
       size_t namelen, char name[],
       unsigned *filter_config );
 herr_t H5Pget_filter_by_id2(hid_t plist_id, H5Z_filter_t id,
       unsigned int *flags , size_t *cd_nelmts ,
       unsigned cd_values[] , size_t namelen, char name[] ,
       unsigned *filter_config );
 htri_t H5Pall_filters_avail(hid_t plist_id);
 herr_t H5Premove_filter(hid_t plist_id, H5Z_filter_t filter);
 herr_t H5Pset_deflate(hid_t plist_id, unsigned aggression);
 herr_t H5Pset_fletcher32(hid_t plist_id);


 herr_t H5Pget_version(hid_t plist_id, unsigned *boot ,
         unsigned *freelist , unsigned *stab ,
         unsigned *shhdr );
 herr_t H5Pset_userblock(hid_t plist_id, hsize_t size);
 herr_t H5Pget_userblock(hid_t plist_id, hsize_t *size);
 herr_t H5Pset_sizes(hid_t plist_id, size_t sizeof_addr,
       size_t sizeof_size);
 herr_t H5Pget_sizes(hid_t plist_id, size_t *sizeof_addr ,
       size_t *sizeof_size );
 herr_t H5Pset_sym_k(hid_t plist_id, unsigned ik, unsigned lk);
 herr_t H5Pget_sym_k(hid_t plist_id, unsigned *ik , unsigned *lk );
 herr_t H5Pset_istore_k(hid_t plist_id, unsigned ik);
 herr_t H5Pget_istore_k(hid_t plist_id, unsigned *ik );
 herr_t H5Pset_shared_mesg_nindexes(hid_t plist_id, unsigned nindexes);
 herr_t H5Pget_shared_mesg_nindexes(hid_t plist_id, unsigned *nindexes);
 herr_t H5Pset_shared_mesg_index(hid_t plist_id, unsigned index_num, unsigned mesg_type_flags, unsigned min_mesg_size);
 herr_t H5Pget_shared_mesg_index(hid_t plist_id, unsigned index_num, unsigned *mesg_type_flags, unsigned *min_mesg_size);
 herr_t H5Pset_shared_mesg_phase_change(hid_t plist_id, unsigned max_list, unsigned min_btree);
 herr_t H5Pget_shared_mesg_phase_change(hid_t plist_id, unsigned *max_list, unsigned *min_btree);



 herr_t H5Pset_alignment(hid_t fapl_id, hsize_t threshold,
    hsize_t alignment);
 herr_t H5Pget_alignment(hid_t fapl_id, hsize_t *threshold ,
    hsize_t *alignment );
 herr_t H5Pset_driver(hid_t plist_id, hid_t driver_id,
        const void *driver_info);
 hid_t H5Pget_driver(hid_t plist_id);
 void *H5Pget_driver_info(hid_t plist_id);
 herr_t H5Pset_family_offset(hid_t fapl_id, hsize_t offset);
 herr_t H5Pget_family_offset(hid_t fapl_id, hsize_t *offset);
 herr_t H5Pset_multi_type(hid_t fapl_id, H5FD_mem_t type);
 herr_t H5Pget_multi_type(hid_t fapl_id, H5FD_mem_t *type);
 herr_t H5Pset_cache(hid_t plist_id, int mdc_nelmts,
       size_t rdcc_nslots, size_t rdcc_nbytes,
       double rdcc_w0);
 herr_t H5Pget_cache(hid_t plist_id,
       int *mdc_nelmts,
       size_t *rdcc_nslots ,
       size_t *rdcc_nbytes , double *rdcc_w0);
 herr_t H5Pset_mdc_config(hid_t plist_id,
       H5AC_cache_config_t * config_ptr);
 herr_t H5Pget_mdc_config(hid_t plist_id,
       H5AC_cache_config_t * config_ptr);
 herr_t H5Pset_gc_references(hid_t fapl_id, unsigned gc_ref);
 herr_t H5Pget_gc_references(hid_t fapl_id, unsigned *gc_ref );
 herr_t H5Pset_fclose_degree(hid_t fapl_id, H5F_close_degree_t degree);
 herr_t H5Pget_fclose_degree(hid_t fapl_id, H5F_close_degree_t *degree);
 herr_t H5Pset_meta_block_size(hid_t fapl_id, hsize_t size);
 herr_t H5Pget_meta_block_size(hid_t fapl_id, hsize_t *size );
 herr_t H5Pset_sieve_buf_size(hid_t fapl_id, size_t size);
 herr_t H5Pget_sieve_buf_size(hid_t fapl_id, size_t *size );
 herr_t H5Pset_small_data_block_size(hid_t fapl_id, hsize_t size);
 herr_t H5Pget_small_data_block_size(hid_t fapl_id, hsize_t *size );
 herr_t H5Pset_libver_bounds(hid_t plist_id, H5F_libver_t low,
    H5F_libver_t high);
 herr_t H5Pget_libver_bounds(hid_t plist_id, H5F_libver_t *low,
    H5F_libver_t *high);
 herr_t H5Pset_elink_file_cache_size(hid_t plist_id, unsigned efc_size);
 herr_t H5Pget_elink_file_cache_size(hid_t plist_id, unsigned *efc_size);
 herr_t H5Pset_file_image(hid_t fapl_id, void *buf_ptr, size_t buf_len);
 herr_t H5Pget_file_image(hid_t fapl_id, void **buf_ptr_ptr, size_t *buf_len_ptr);
 herr_t H5Pset_file_image_callbacks(hid_t fapl_id,
       H5FD_file_image_callbacks_t *callbacks_ptr);
 herr_t H5Pget_file_image_callbacks(hid_t fapl_id,
       H5FD_file_image_callbacks_t *callbacks_ptr);


 herr_t H5Pset_layout(hid_t plist_id, H5D_layout_t layout);
 H5D_layout_t H5Pget_layout(hid_t plist_id);
 herr_t H5Pset_chunk(hid_t plist_id, int ndims, const hsize_t dim[ ]);
 int H5Pget_chunk(hid_t plist_id, int max_ndims, hsize_t dim[] );
 herr_t H5Pset_external(hid_t plist_id, const char *name, off_t offset,
          hsize_t size);
 int H5Pget_external_count(hid_t plist_id);
 herr_t H5Pget_external(hid_t plist_id, unsigned idx, size_t name_size,
          char *name , off_t *offset ,
          hsize_t *size );
 herr_t H5Pset_szip(hid_t plist_id, unsigned options_mask, unsigned pixels_per_block);
 herr_t H5Pset_shuffle(hid_t plist_id);
 herr_t H5Pset_nbit(hid_t plist_id);
 herr_t H5Pset_scaleoffset(hid_t plist_id, H5Z_SO_scale_type_t scale_type, int scale_factor);
 herr_t H5Pset_fill_value(hid_t plist_id, hid_t type_id,
     const void *value);
 herr_t H5Pget_fill_value(hid_t plist_id, hid_t type_id,
     void *value );
 herr_t H5Pfill_value_defined(hid_t plist, H5D_fill_value_t *status);
 herr_t H5Pset_alloc_time(hid_t plist_id, H5D_alloc_time_t
 alloc_time);
 herr_t H5Pget_alloc_time(hid_t plist_id, H5D_alloc_time_t
 *alloc_time );
 herr_t H5Pset_fill_time(hid_t plist_id, H5D_fill_time_t fill_time);
 herr_t H5Pget_fill_time(hid_t plist_id, H5D_fill_time_t
 *fill_time );


 herr_t H5Pset_chunk_cache(hid_t dapl_id, size_t rdcc_nslots,
       size_t rdcc_nbytes, double rdcc_w0);
 herr_t H5Pget_chunk_cache(hid_t dapl_id,
       size_t *rdcc_nslots ,
       size_t *rdcc_nbytes ,
       double *rdcc_w0 );


 herr_t H5Pset_data_transform(hid_t plist_id, const char* expression);
 ssize_t H5Pget_data_transform(hid_t plist_id, char* expression , size_t size);
 herr_t H5Pset_buffer(hid_t plist_id, size_t size, void *tconv,
        void *bkg);
 size_t H5Pget_buffer(hid_t plist_id, void **tconv ,
        void **bkg );
 herr_t H5Pset_preserve(hid_t plist_id, hbool_t status);
 int H5Pget_preserve(hid_t plist_id);
 herr_t H5Pset_edc_check(hid_t plist_id, H5Z_EDC_t check);
 H5Z_EDC_t H5Pget_edc_check(hid_t plist_id);
 herr_t H5Pset_filter_callback(hid_t plist_id, H5Z_filter_func_t func,
                                     void* op_data);
 herr_t H5Pset_btree_ratios(hid_t plist_id, double left, double middle,
       double right);
 herr_t H5Pget_btree_ratios(hid_t plist_id, double *left ,
       double *middle ,
       double *right );
 herr_t H5Pset_vlen_mem_manager(hid_t plist_id,
                                       H5MM_allocate_t alloc_func,
                                       void *alloc_info, H5MM_free_t free_func,
                                       void *free_info);
 herr_t H5Pget_vlen_mem_manager(hid_t plist_id,
                                       H5MM_allocate_t *alloc_func,
                                       void **alloc_info,
                                       H5MM_free_t *free_func,
                                       void **free_info);
 herr_t H5Pset_hyper_vector_size(hid_t fapl_id, size_t size);
 herr_t H5Pget_hyper_vector_size(hid_t fapl_id, size_t *size );
 herr_t H5Pset_type_conv_cb(hid_t dxpl_id, H5T_conv_except_func_t op, void* operate_data);
 herr_t H5Pget_type_conv_cb(hid_t dxpl_id, H5T_conv_except_func_t *op, void** operate_data);







 herr_t H5Pset_create_intermediate_group(hid_t plist_id, unsigned crt_intmd);
 herr_t H5Pget_create_intermediate_group(hid_t plist_id, unsigned *crt_intmd );


 herr_t H5Pset_local_heap_size_hint(hid_t plist_id, size_t size_hint);
 herr_t H5Pget_local_heap_size_hint(hid_t plist_id, size_t *size_hint );
 herr_t H5Pset_link_phase_change(hid_t plist_id, unsigned max_compact, unsigned min_dense);
 herr_t H5Pget_link_phase_change(hid_t plist_id, unsigned *max_compact , unsigned *min_dense );
 herr_t H5Pset_est_link_info(hid_t plist_id, unsigned est_num_entries, unsigned est_name_len);
 herr_t H5Pget_est_link_info(hid_t plist_id, unsigned *est_num_entries , unsigned *est_name_len );
 herr_t H5Pset_link_creation_order(hid_t plist_id, unsigned crt_order_flags);
 herr_t H5Pget_link_creation_order(hid_t plist_id, unsigned *crt_order_flags );


 herr_t H5Pset_char_encoding(hid_t plist_id, H5T_cset_t encoding);
 herr_t H5Pget_char_encoding(hid_t plist_id, H5T_cset_t *encoding );


 herr_t H5Pset_nlinks(hid_t plist_id, size_t nlinks);
 herr_t H5Pget_nlinks(hid_t plist_id, size_t *nlinks);
 herr_t H5Pset_elink_prefix(hid_t plist_id, const char *prefix);
 ssize_t H5Pget_elink_prefix(hid_t plist_id, char *prefix, size_t size);
 hid_t H5Pget_elink_fapl(hid_t lapl_id);
 herr_t H5Pset_elink_fapl(hid_t lapl_id, hid_t fapl_id);
 herr_t H5Pset_elink_acc_flags(hid_t lapl_id, unsigned flags);
 herr_t H5Pget_elink_acc_flags(hid_t lapl_id, unsigned *flags);
 herr_t H5Pset_elink_cb(hid_t lapl_id, H5L_elink_traverse_t func, void *op_data);
 herr_t H5Pget_elink_cb(hid_t lapl_id, H5L_elink_traverse_t *func, void **op_data);


 herr_t H5Pset_copy_object(hid_t plist_id, unsigned crt_intmd);
 herr_t H5Pget_copy_object(hid_t plist_id, unsigned *crt_intmd );
 herr_t H5Padd_merge_committed_dtype_path(hid_t plist_id, const char *path);
 herr_t H5Pfree_merge_committed_dtype_paths(hid_t plist_id);
 herr_t H5Pset_mcdt_search_cb(hid_t plist_id, H5O_mcdt_search_cb_t func, void *op_data);
 herr_t H5Pget_mcdt_search_cb(hid_t plist_id, H5O_mcdt_search_cb_t *func, void **op_data);
# 472 "H5Ppublic.h"
 herr_t H5Pregister1(hid_t cls_id, const char *name, size_t size,
    void *def_value, H5P_prp_create_func_t prp_create,
    H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
    H5P_prp_delete_func_t prp_del, H5P_prp_copy_func_t prp_copy,
    H5P_prp_close_func_t prp_close);
 herr_t H5Pinsert1(hid_t plist_id, const char *name, size_t size,
    void *value, H5P_prp_set_func_t prp_set, H5P_prp_get_func_t prp_get,
    H5P_prp_delete_func_t prp_delete, H5P_prp_copy_func_t prp_copy,
    H5P_prp_close_func_t prp_close);
 H5Z_filter_t H5Pget_filter1(hid_t plist_id, unsigned filter,
    unsigned int *flags , size_t *cd_nelmts ,
    unsigned cd_values[] , size_t namelen, char name[]);
 herr_t H5Pget_filter_by_id1(hid_t plist_id, H5Z_filter_t id,
    unsigned int *flags , size_t *cd_nelmts ,
    unsigned cd_values[] , size_t namelen, char name[] );
# 37 "hdf5.h" 2
# 1 "H5Rpublic.h" 1
# 30 "H5Rpublic.h"
typedef enum {
    H5R_BADTYPE = (-1),
    H5R_OBJECT,
    H5R_DATASET_REGION,
    H5R_MAXTYPE
} H5R_type_t;
# 44 "H5Rpublic.h"
typedef haddr_t hobj_ref_t;






typedef unsigned char hdset_reg_ref_t[(sizeof(haddr_t)+4)];
# 61 "H5Rpublic.h"
 herr_t H5Rcreate(void *ref, hid_t loc_id, const char *name,
    H5R_type_t ref_type, hid_t space_id);
 hid_t H5Rdereference(hid_t dataset, H5R_type_t ref_type, const void *ref);
 hid_t H5Rget_region(hid_t dataset, H5R_type_t ref_type, const void *ref);
 herr_t H5Rget_obj_type2(hid_t id, H5R_type_t ref_type, const void *_ref,
    H5O_type_t *obj_type);
 ssize_t H5Rget_name(hid_t loc_id, H5R_type_t ref_type, const void *ref,
    char *name , size_t size);
# 83 "H5Rpublic.h"
 H5G_obj_t H5Rget_obj_type1(hid_t id, H5R_type_t ref_type, const void *_ref);
# 38 "hdf5.h" 2
# 1 "H5Spublic.h" 1
# 34 "H5Spublic.h"
typedef enum H5S_class_t {
    H5S_NO_CLASS = -1,
    H5S_SCALAR = 0,
    H5S_SIMPLE = 1,
    H5S_NULL = 2
} H5S_class_t;


typedef enum H5S_seloper_t {
    H5S_SELECT_NOOP = -1,
    H5S_SELECT_SET = 0,
    H5S_SELECT_OR,





    H5S_SELECT_AND,





    H5S_SELECT_XOR,





    H5S_SELECT_NOTB,





    H5S_SELECT_NOTA,





    H5S_SELECT_APPEND,
    H5S_SELECT_PREPEND,
    H5S_SELECT_INVALID
} H5S_seloper_t;


typedef enum {
    H5S_SEL_ERROR = -1,
    H5S_SEL_NONE = 0,
    H5S_SEL_POINTS = 1,
    H5S_SEL_HYPERSLABS = 2,
    H5S_SEL_ALL = 3,
    H5S_SEL_N
}H5S_sel_type;






 hid_t H5Screate(H5S_class_t type);
 hid_t H5Screate_simple(int rank, const hsize_t dims[],
          const hsize_t maxdims[]);
 herr_t H5Sset_extent_simple(hid_t space_id, int rank,
        const hsize_t dims[],
        const hsize_t max[]);
 hid_t H5Scopy(hid_t space_id);
 herr_t H5Sclose(hid_t space_id);
 herr_t H5Sencode(hid_t obj_id, void *buf, size_t *nalloc);
 hid_t H5Sdecode(const void *buf);
 hssize_t H5Sget_simple_extent_npoints(hid_t space_id);
 int H5Sget_simple_extent_ndims(hid_t space_id);
 int H5Sget_simple_extent_dims(hid_t space_id, hsize_t dims[],
          hsize_t maxdims[]);
 htri_t H5Sis_simple(hid_t space_id);
 hssize_t H5Sget_select_npoints(hid_t spaceid);
 herr_t H5Sselect_hyperslab(hid_t space_id, H5S_seloper_t op,
       const hsize_t start[],
       const hsize_t _stride[],
       const hsize_t count[],
       const hsize_t _block[]);
# 128 "H5Spublic.h"
 herr_t H5Sselect_elements(hid_t space_id, H5S_seloper_t op,
    size_t num_elem, const hsize_t *coord);
 H5S_class_t H5Sget_simple_extent_type(hid_t space_id);
 herr_t H5Sset_extent_none(hid_t space_id);
 herr_t H5Sextent_copy(hid_t dst_id,hid_t src_id);
 htri_t H5Sextent_equal(hid_t sid1, hid_t sid2);
 herr_t H5Sselect_all(hid_t spaceid);
 herr_t H5Sselect_none(hid_t spaceid);
 herr_t H5Soffset_simple(hid_t space_id, const hssize_t *offset);
 htri_t H5Sselect_valid(hid_t spaceid);
 hssize_t H5Sget_select_hyper_nblocks(hid_t spaceid);
 hssize_t H5Sget_select_elem_npoints(hid_t spaceid);
 herr_t H5Sget_select_hyper_blocklist(hid_t spaceid, hsize_t startblock,
    hsize_t numblocks, hsize_t buf[ ]);
 herr_t H5Sget_select_elem_pointlist(hid_t spaceid, hsize_t startpoint,
    hsize_t numpoints, hsize_t buf[ ]);
 herr_t H5Sget_select_bounds(hid_t spaceid, hsize_t start[],
    hsize_t end[]);
 H5S_sel_type H5Sget_select_type(hid_t spaceid);
# 39 "hdf5.h" 2




# 1 "H5FDcore.h" 1
# 32 "H5FDcore.h"
 hid_t H5FD_core_init(void);
 void H5FD_core_term(void);
 herr_t H5Pset_fapl_core(hid_t fapl_id, size_t increment,
    hbool_t backing_store);
 herr_t H5Pget_fapl_core(hid_t fapl_id, size_t *increment ,
    hbool_t *backing_store );
# 44 "hdf5.h" 2
# 1 "H5FDfamily.h" 1
# 33 "H5FDfamily.h"
 hid_t H5FD_family_init(void);
 void H5FD_family_term(void);
 herr_t H5Pset_fapl_family(hid_t fapl_id, hsize_t memb_size,
     hid_t memb_fapl_id);
 herr_t H5Pget_fapl_family(hid_t fapl_id, hsize_t *memb_size ,
     hid_t *memb_fapl_id );
# 45 "hdf5.h" 2
# 1 "H5FDlog.h" 1
# 63 "H5FDlog.h"
 hid_t H5FD_log_init(void);
 void H5FD_log_term(void);
 herr_t H5Pset_fapl_log(hid_t fapl_id, const char *logfile, unsigned long long flags, size_t buf_size);
# 46 "hdf5.h" 2
# 1 "H5FDmpi.h" 1
# 40 "H5FDmpi.h"
typedef enum H5FD_mpio_xfer_t {
    H5FD_MPIO_INDEPENDENT = 0,
    H5FD_MPIO_COLLECTIVE
} H5FD_mpio_xfer_t;


typedef enum H5FD_mpio_chunk_opt_t {
    H5FD_MPIO_CHUNK_DEFAULT = 0,
    H5FD_MPIO_CHUNK_ONE_IO,
    H5FD_MPIO_CHUNK_MULTI_IO
} H5FD_mpio_chunk_opt_t;


typedef enum H5FD_mpio_collective_opt_t {
    H5FD_MPIO_COLLECTIVE_IO = 0,
    H5FD_MPIO_INDIVIDUAL_IO
} H5FD_mpio_collective_opt_t;


# 1 "H5FDmpio.h" 1
# 60 "H5FDmpi.h" 2
# 1 "H5FDmpiposix.h" 1
# 61 "H5FDmpi.h" 2
# 47 "hdf5.h" 2
# 1 "H5FDmulti.h" 1
# 34 "H5FDmulti.h"
 hid_t H5FD_multi_init(void);
 void H5FD_multi_term(void);
 herr_t H5Pset_fapl_multi(hid_t fapl_id, const H5FD_mem_t *memb_map,
    const hid_t *memb_fapl, const char * const *memb_name,
    const haddr_t *memb_addr, hbool_t relax);
 herr_t H5Pget_fapl_multi(hid_t fapl_id, H5FD_mem_t *memb_map ,
    hid_t *memb_fapl , char **memb_name ,
    haddr_t *memb_addr , hbool_t *relax );
 herr_t H5Pset_fapl_split(hid_t fapl, const char *meta_ext,
    hid_t meta_plist_id, const char *raw_ext,
    hid_t raw_plist_id);
# 48 "hdf5.h" 2
# 1 "H5FDsec2.h" 1
# 33 "H5FDsec2.h"
 hid_t H5FD_sec2_init(void);
 void H5FD_sec2_term(void);
 herr_t H5Pset_fapl_sec2(hid_t fapl_id);
# 49 "hdf5.h" 2
# 1 "H5FDstdio.h" 1
# 33 "H5FDstdio.h"
 hid_t H5FD_stdio_init(void);
 void H5FD_stdio_term(void);
 herr_t H5Pset_fapl_stdio(hid_t fapl_id);
# 50 "hdf5.h" 2



# 1 "H5FDdirect.h" 1
# 54 "hdf5.h" 2
