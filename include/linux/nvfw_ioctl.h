/*
 * tegra/core/include/linux/nvfw_ioctl.h
 *
 * structure declarations for nvfw ioctls
 *
 * Copyright (c) 2010-2011 NVIDIA Corporation.  All rights reserved.
 *
 * NVIDIA Corporation and its licensors retain all intellectual property
 * and proprietary rights in and to this software, related documentation
 * and any modifications thereto.  Any use, reproduction, disclosure or
 * distribution of this software and related documentation without an express
 * license agreement from NVIDIA Corporation is strictly prohibited.
 */

#include <linux/ioctl.h>
#include <linux/types.h>

#if !defined(__KERNEL__)
#define __user
#endif

#ifndef _MACH_TEGRA_NVFW_IOCTL_H_
#define _MACH_TEGRA_NVFW_IOCTL_H_

struct nvfw_load_handle {
       const char *filename;
       int length;
       void *args;
       int argssize;
       int greedy;
       void *handle;
};

struct nvfw_get_proc_address_handle {
       const char *symbolname;
       int length;
       void *address;
       void *handle;
};

#define NVFW_IOC_MAGIC 'N'
#define NVFW_IOC_LOAD_LIBRARY     _IOWR(NVFW_IOC_MAGIC, 0x50, struct nvfw_load_handle)
#define NVFW_IOC_LOAD_LIBRARY_EX  _IOWR(NVFW_IOC_MAGIC, 0x51, struct nvfw_load_handle)
#define NVFW_IOC_FREE_LIBRARY     _IOW (NVFW_IOC_MAGIC, 0x52, struct nvfw_load_handle)
#define NVFW_IOC_GET_PROC_ADDRESS _IOWR(NVFW_IOC_MAGIC, 0x53, struct nvfw_load_handle)

#endif
