/*
 * Copyright (c) 2009 NVIDIA Corporation.  All rights reserved.
 *
 * NVIDIA Corporation and its licensors retain all intellectual property
 * and proprietary rights in and to this software, related documentation
 * and any modifications thereto.  Any use, reproduction, disclosure or
 * distribution of this software and related documentation without an express
 * license agreement from NVIDIA Corporation is strictly prohibited.
 */

#if defined(__linux__)
#include <linux/ioctl.h>
#endif

#include "nvos.h"
#include "nvcommon.h"

#ifndef NVOS_LINUX_IOCTLS_H
#define NVOS_LINUX_IOCTLS_H

typedef struct
{
    NvU32 IoctlCode;
    NvU32 InBufferSize;
    NvU32 InOutBufferSize;
    NvU32 OutBufferSize;
    void *pBuffer;
} NV_ALIGN(4) NvOsIoctlParams;

typedef struct
{
    NvOsSemaphoreHandle sem;
    NvU32 value;
    NvError error;
} NV_ALIGN(4) NvOsSemaphoreIoctlParams;

typedef struct
{
    NvOsSemaphoreHandle hOrig;
    NvOsSemaphoreHandle hNew;
    NvError             Error;
} NV_ALIGN(4) NvOsSemaphoreUnmarshalParams;

typedef struct
{
    NvOsSemaphoreHandle hOrig;
    NvOsSemaphoreHandle hNew;
    NvError             Error;
} NV_ALIGN(4) NvOsSemaphoreCloneParams;

typedef struct
{
    NvU32 nIrqs;
    const NvU32 *Irqs;
    NvOsSemaphoreHandle *SemaphoreList;
    NvError errCode;
    NvUPtr  kernelHandle;
} NV_ALIGN(4) NvOsInterruptRegisterParams;

typedef struct
{
    NvUPtr  handle;
    NvU32   arg;
    NvError errCode;
} NV_ALIGN(4) NvOsInterruptOpParams;

typedef struct
{
    NvUPtr handle;
    NvU32 mask;
} NV_ALIGN(4) NvOsInterruptMaskParams;

typedef struct
{
    NvU32 size;
    char *text;
} NV_ALIGN(4) NvOsDebugStringParams;

typedef struct
{
    NvOsPhysAddr base;
    NvU32 size;
} NV_ALIGN(4) NvOsMemRangeParams;

#define NV_IOCTL_SEMAPHORE_CREATE   _IOWR('N', 0x20, NvOsSemaphoreIoctlParams)
#define NV_IOCTL_SEMAPHORE_DESTROY  _IOW('N', 0x21, NvOsSemaphoreHandle)
#define NV_IOCTL_SEMAPHORE_CLONE \
    _IOWR('N', 0x22, NvOsSemaphoreCloneParams)
#define NV_IOCTL_SEMAPHORE_UNMARSHAL \
    _IOWR('N', 0x23, NvOsSemaphoreUnmarshalParams)
#define NV_IOCTL_SEMAPHORE_SIGNAL   _IOW('N', 0x24, NvOsSemaphoreHandle)
#define NV_IOCTL_SEMAPHORE_WAIT     _IOW('N', 0x25, NvOsSemaphoreHandle)
#define NV_IOCTL_SEMAPHORE_WAIT_TIMEOUT \
    _IOW('N', 0x26, NvOsSemaphoreIoctlParams)
#define NV_IOCTL_INTERRUPT_REGISTER \
    _IOWR('N', 0x27, NvOsInterruptRegisterParams)
#define NV_IOCTL_INTERRUPT_UNREGISTER   _IOWR('N', 0x28, NvOsInterruptOpParams)
#define NV_IOCTL_INTERRUPT_ENABLE       _IOWR('N', 0x29, NvOsInterruptOpParams)
#define NV_IOCTL_INTERRUPT_DONE         _IOWR('N', 0x2A, NvOsInterruptOpParams)
#define NV_IOCTL_INTERRUPT_MASK     _IOWR('N', 0x2B, NvOsInterruptOpParams)
#define NV_IOCTL_GLOBAL_LOCK        _IO('N', 0x2C)
#define NV_IOCTL_GLOBAL_UNLOCK      _IO('N', 0x2D)
#define NV_IOCTL_DEBUG_STRING       _IOW('N', 0x2E, NvOsDebugStringParams)
#define NV_IOCTL_MEMORY_RANGE       _IOW('N', 0x2F, NvOsMemRangeParams)

#endif
