#!/usr/bin/python

import glob
import os
import os.path

config_dir = os.path.dirname(__file__)
working_dir = os.getcwd()

# Load target config if available
gdbinit_target = os.path.join(config_dir, gdb.TARGET_CONFIG)
if os.path.exists(os.path.expanduser(gdbinit_target)):
    gdb.execute('source %s' % gdbinit_target)
if os.path.exists(os.path.expanduser(gdbinit_target) + ".py"):
    gdb.execute('source %s.py' % gdbinit_target)
