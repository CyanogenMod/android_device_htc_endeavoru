# Copyright (C) 2013 The Android Open Source Project
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Custom OTA commands for endeavoru"""

import common
import os
import shutil

# CWM displays 48 chars.                     ->|
LAYOUT_ERROR_MESSAGE = """
Your recovery is using the new storage layout
but the ROM you're trying to install is not.

Flash a compatible recovery and format /data and
/sdcard or use a compatible ROM.

For more information see: http://goo.gl/vvy4c7
"""

# Property is '1' if the new format is supported and '' if not
PROPERTY='ro.build.endeavoru.newlayout'

def FullOTA_Assertions(self):
  self.script.AssertSomeBootloader("1.28.0000", "1.31.0000", "1.33.0000",
                                   "1.36.0000", "1.39.0000", "1.72.0000",
                                   "1.73.0000")

def FullOTA_InstallBegin(self):
  self.script.AppendExtra('package_extract_file("%s", "%s");' % ("system/build.prop",
                                                                 "/tmp/rom.prop"))

  self.script.AppendExtra('file_getprop("/tmp/rom.prop", "%s");' % PROPERTY)

  rom_prop = 'file_getprop("/tmp/rom.prop", "%s")' % PROPERTY
  recovery_prop = 'getprop("%s")' % PROPERTY
  
  # Check if the properties are equal
  self.script.AppendExtra('ifelse(%s != %s,' % (rom_prop, recovery_prop))

  for line in LAYOUT_ERROR_MESSAGE.split('\n'):
    self.script.AppendExtra('ui_print("%s"); ' % line)

  self.script.AppendExtra('abort("Incompatible ROM storage layout"); );')
