# This script is used to generate reference HDF5 files. It uses h5py, so that
# we can compare against that implementation.

import h5py
import argparse
import os
from collections import namedtuple
import numpy as np

parser = argparse.ArgumentParser()
parser.add_argument("out")
args = parser.parse_args()

Case = namedtuple('Case', ['name', 'data'])
testCases = []

def addTestCase(name, data):
    testCases.append(Case(name, data))

class Data(object):
    def __init__(self, w, h, x, y):
        super(Data, self).__init__()
        self.w = w
        self.h = h
        self.x = x
        self.y = y

    def asPython(self, h5, name):
        h5.create_dataset(name, (self.w, self.h))
        h5[name][...] = np.linspace(self.x, self.y, self.w * self.h).reshape(self.w, self.h)

    def asLua(self):
        out = ""
        out += "torch.linspace(%s, %s, %s)" % (self.x, self.y, self.w * self.h)
        out += ":resize(%s, %s):float()" % (self.w, self.h)
        return out

def luaDefinition(data):
    return "return " + luaDefinitionHelper(data, 0)

def luaDefinitionHelper(data, level):

    text = ""
    indent = "    "
    if isinstance(data, dict):
        text = "{\n"
        for k, v in data.iteritems():
            text += indent * (level + 1) + k + " = " + luaDefinitionHelper(v, level + 1) + ",\n"
        text += indent * level + "}"
    else:
        text += data.asLua()
    return text

def writeH5(h5, data):
    for k, v in data.iteritems():
        if isinstance(v, dict):
            group = h5.create_group(k)
            writeH5(group, v)
            continue
        v.asPython(h5, k)

addTestCase('empty', {})
addTestCase('oneTensor', { 'data' : Data(10, 10, 0, 100) })
addTestCase('twoTensors', { 'data1' : Data(10, 10, 0, 100), 'data2' : Data(10, 10, 0, 10) })
addTestCase('twoTensorsNested', { 'group' : { 'data' : Data(10, 10, 0, 100) } })

for case in testCases:
    print("=== Generating %s ===" % (case.name,))
    h5file = h5py.File(os.path.join(args.out, case.name + ".h5"), 'w')
    writeH5(h5file, case.data)
    luaFilePath = os.path.join(args.out, case.name + ".lua")
    with open(luaFilePath, 'w') as luaFile:
        luaFile.write(luaDefinition(case.data))
