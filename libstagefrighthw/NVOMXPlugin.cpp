/*
 * Copyright (C) 2009 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "NVOMXPlugin.h"

#include <dlfcn.h>
#include <string.h>

#include <media/hardware/HardwareAPI.h>

namespace android {

OMXPluginBase *createOMXPlugin() {
    return new NVOMXPlugin;
}

NVOMXPlugin::NVOMXPlugin()
    : mLibHandle(dlopen("libnvomx.so", RTLD_NOW)),
      mInit(NULL),
      mDeinit(NULL),
      mComponentNameEnum(NULL),
      mGetHandle(NULL),
      mFreeHandle(NULL),
      mGetRolesOfComponentHandle(NULL) {
    if (mLibHandle != NULL) {
        mInit = (InitFunc)dlsym(mLibHandle, "OMX_Init");
        mDeinit = (DeinitFunc)dlsym(mLibHandle, "OMX_Deinit");

        mComponentNameEnum =
            (ComponentNameEnumFunc)dlsym(mLibHandle, "OMX_ComponentNameEnum");

        mGetHandle = (GetHandleFunc)dlsym(mLibHandle, "OMX_GetHandle");
        mFreeHandle = (FreeHandleFunc)dlsym(mLibHandle, "OMX_FreeHandle");

        mGetRolesOfComponentHandle =
            (GetRolesOfComponentFunc)dlsym(
                    mLibHandle, "OMX_GetRolesOfComponent");

        (*mInit)();
    }
}

NVOMXPlugin::~NVOMXPlugin() {
    if (mLibHandle != NULL) {
        (*mDeinit)();

        dlclose(mLibHandle);
        mLibHandle = NULL;
    }
}

OMX_ERRORTYPE NVOMXPlugin::makeComponentInstance(
        const char *name,
        const OMX_CALLBACKTYPE *callbacks,
        OMX_PTR appData,
        OMX_COMPONENTTYPE **component) {
    OMX_ERRORTYPE err = OMX_ErrorUndefined;
    if (mLibHandle == NULL) {
        goto exit;
    }
    err = (*mGetHandle)(reinterpret_cast<OMX_HANDLETYPE *>(component),
            const_cast<char *>(name), appData,
                const_cast<OMX_CALLBACKTYPE *>(callbacks));
    if (strncmp(name, "OMX.Nvidia.drm.play", 19) == 0) {
        gOMXDrmPlayComponent = *component;
    }

exit:
    return err;
}

OMX_ERRORTYPE NVOMXPlugin::destroyComponentInstance(
        OMX_COMPONENTTYPE *component) {
    OMX_ERRORTYPE err = OMX_ErrorUndefined;
    if (mLibHandle == NULL) {
        goto exit;
    }
    if (component == gOMXDrmPlayComponent) {
        gOMXDrmPlayComponent = NULL;
    }
    err = (*mFreeHandle)(reinterpret_cast<OMX_HANDLETYPE *>(component));

exit:
    return err;
}

OMX_ERRORTYPE NVOMXPlugin::enumerateComponents(
        OMX_STRING name,
        size_t size,
        OMX_U32 index) {
    if (mLibHandle == NULL) {
        return OMX_ErrorUndefined;
    }

    return (*mComponentNameEnum)(name, size, index);
}

OMX_ERRORTYPE NVOMXPlugin::getRolesOfComponent(
        const char *name,
        Vector<String8> *roles) {
    roles->clear();

    if (mLibHandle == NULL) {
        return OMX_ErrorUndefined;
    }

    OMX_U32 numRoles;
    OMX_ERRORTYPE err = (*mGetRolesOfComponentHandle)(
            const_cast<OMX_STRING>(name), &numRoles, NULL);

    if (err != OMX_ErrorNone) {
        return err;
    }

    if (numRoles > 0) {
        OMX_U8 **array = new OMX_U8 *[numRoles];
        for (OMX_U32 i = 0; i < numRoles; ++i) {
            array[i] = new OMX_U8[OMX_MAX_STRINGNAME_SIZE];
        }

        OMX_U32 numRoles2;
        err = (*mGetRolesOfComponentHandle)(
                const_cast<OMX_STRING>(name), &numRoles2, array);

    if (err != OMX_ErrorNone) {
      return err;
    }

    if (numRoles2 != numRoles) {
      return err;
    }

        for (OMX_U32 i = 0; i < numRoles; ++i) {
            String8 s((const char *)array[i]);
            roles->push(s);

            delete[] array[i];
            array[i] = NULL;
        }

        delete[] array;
        array = NULL;
    }

    return OMX_ErrorNone;
}

}  // namespace android
