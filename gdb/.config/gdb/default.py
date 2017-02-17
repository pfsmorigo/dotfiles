#!/usr/bin/python

import glob
import os
import os.path

class DynamicBreakpoint(gdb.Function):
    def __init__ (self):
        super (DynamicBreakpoint, self).__init__ ("dynbreak")

    def invoke (self, filename, match):
        with open(filename.string()) as myFile:
            for num, line in enumerate(myFile, 1):
                if match.string() in line:
                    gdb.execute('b %s:%d' % (filename.string(), num))
                    return "Success!"
        return "Line not found!"

DynamicBreakpoint()

config_dir = os.path.dirname(__file__)
working_dir = os.getcwd()

# Load target config if available
gdbinit_target = os.path.join(config_dir, gdb.TARGET_CONFIG)
if os.path.exists(os.path.expanduser(gdbinit_target)):
    gdb.execute('source %s' % gdbinit_target)
if os.path.exists(os.path.expanduser(gdbinit_target) + ".py"):
    gdb.execute('source %s.py' % gdbinit_target)
