/*
 * tegra/core/include/linux/nvavp_ioctl.h
 *
 * Declarations for nvavp driver ioctls
 *
 * Copyright (c) 2011, NVIDIA Corporation.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include <linux/ioctl.h>
#include <linux/types.h>

#if !defined(__KERNEL__)
#define __user
#endif

#ifndef __NVAVP_IOCTL_H
#define __NVAVP_IOCTL_H

#define NVAVP_MAX_RELOCATION_COUNT 64

/* avp submit flags */
#define NVAVP_FLAG_NONE            0x00000000
#define NVAVP_UCODE_EXT            0x00000001 /*use external ucode provided */

struct nvavp_cmdbuf {
        __u32 mem;
        __u32 offset;
        __u32 words;
};

struct nvavp_reloc {
        __u32 cmdbuf_mem;
        __u32 cmdbuf_offset;
        __u32 target;
        __u32 target_offset;
};

struct nvavp_syncpt {
        __u32 id;
        __u32 value;
};

struct nvavp_pushbuffer_submit_hdr {
        struct nvavp_cmdbuf       cmdbuf;
        struct nvavp_reloc        *relocs;
        __u32                     num_relocs;
        struct nvavp_syncpt       *syncpt;
        __u32                     flags;
};

struct nvavp_set_nvmap_fd_args {
        __u32 fd;
};

struct nvavp_clock_args {
        __u32 id;
        __u32 rate;
};

#define NVAVP_IOCTL_MAGIC              'n'

#define NVAVP_IOCTL_SET_NVMAP_FD       _IOW(NVAVP_IOCTL_MAGIC, 0x60, struct nvavp_set_nvmap_fd_args)
#define NVAVP_IOCTL_GET_SYNCPOINT_ID   _IOR(NVAVP_IOCTL_MAGIC, 0x61, __u32)
#define NVAVP_IOCTL_PUSH_BUFFER_SUBMIT _IOWR(NVAVP_IOCTL_MAGIC, 0x63, struct nvavp_pushbuffer_submit_hdr)
#define NVAVP_IOCTL_SET_CLOCK          _IOWR(NVAVP_IOCTL_MAGIC, 0x64, struct nvavp_clock_args)
#define NVAVP_IOCTL_GET_CLOCK          _IOR(NVAVP_IOCTL_MAGIC, 0x65, struct nvavp_clock_args)

#define NVAVP_IOCTL_MIN_NR             _IOC_NR(NVAVP_IOCTL_SET_NVMAP_FD)
#define NVAVP_IOCTL_MAX_NR             _IOC_NR(NVAVP_IOCTL_GET_CLOCK)

#endif
