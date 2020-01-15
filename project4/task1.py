#!/usr/bin/env python3

import sys
import os
import numpy
import numpy.linalg
import scipy.misc

def getOutputPngName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.png'

def getOutputNpyName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.npy'

if len(sys.argv) < 3:
    sys.exit('usage: task1.py <PNG inputFile> <rank>')

inputfile = sys.argv[1]
rank = int(sys.argv[2])
outputpng = getOutputPngName(inputfile, rank)
outputnpy = getOutputNpyName(inputfile, rank)

#
# TODO: The current code just prints out what it is supposed to to
#       Replace the print statement wth your code
#
fileMatrix = scipy.misc.imread(inputfile)
u, s, vh = numpy.linalg.svd(fileMatrix)
output = numpy.dot(u[:, :rank] * s[:rank], vh[:rank])
numpy.save(outputnpy, output)
scipy.misc.imsave(outputpng, output)
