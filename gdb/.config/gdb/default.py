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

# Load target config if available
targets = []
targets.append(gdb.TARGET_CONFIG) # architecture specifics
targets.append(targets[-1]+".py")
targets.append(os.getcwd()[len(os.getenv("HOME"))+1:].replace('/', '_')) # project specifics
targets.append(targets[-1]+".py")

for target in targets:
    fullpath = "%s/%s" % (os.path.dirname(__file__), target)
    if os.path.exists(os.path.expanduser(fullpath)):
        print("Loading %s..." % fullpath)
        gdb.execute("source %s" % fullpath)
