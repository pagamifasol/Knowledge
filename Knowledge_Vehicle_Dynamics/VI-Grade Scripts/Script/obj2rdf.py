# obj2rdf.py

import os, sys

def readObj(filename):
    print filename
    nodes = []
    connections = []
    materials = []
    # nodes.append([1,0,0])
    # nodes.append([0,1,0])
    # nodes.append([0,0,1])
    # connections.append([1,2,3])
    # connections.append([2,3,4])
    # connections.append([3,4,5])
    f = open(filename, 'r')
    lines = f.readlines()
    f.close()
    id = 1  # first id value
    for line in lines:
        tokens = line.strip().split()
        if tokens[0]=='g':
            materials.append(tokens[1])

        if len(tokens)<4:
            continue
        # if vertex
        if tokens[0]=='v':
            nodes.append([id, float(tokens[1].split('/',1)[0]), float(tokens[2].split('/',1)[0]), float(tokens[3].split('/',1)[0])])
            id = id+1
        # if face
        if tokens[0]=='f':
            connections.append([int(tokens[1].split('/',1)[0]), int(tokens[2].split('/',1)[0]), int(tokens[3].split('/',1)[0]), len(materials) ])
    return nodes, connections, materials


def writeRdf(nodes, connections, materials, filename):
    print filename
    # print nodes
    # print connections
    f = open(filename,'w')
    f.write("$-----------------------------------------------------------------VIGRADE_HEADER\n")
    f.write("[VIGRADE_HEADER]                                                                \n")
    f.write("FILE_TYPE = 'RDF'                                                               \n")
    f.write("FILE_VERSION = 12                                                               \n")
    f.write("FILE_FORMAT = 'ASCII'                                                           \n")
    f.write("$--------------------------------------------------------------------------UNITS\n")
    f.write("[UNITS]                                                                         \n")
    f.write("LENGTH = 'METER'                                                                \n")
    f.write("ANGLE = 'RADIAN'                                                                \n")
    f.write("FORCE = 'NEWTON'                                                                \n")
    f.write("MASS = 'KILOGRAM'                                                               \n")
    f.write("TIME = 'SECOND'                                                                 \n")
    f.write("$--------------------------------------------------------------------------MODEL\n")
    f.write("[MODEL]                                                                         \n")
    f.write("METHOD = 'USER'                                                                 \n")
    f.write("FUNCTION_NAME = 'VITOOLS::VI_ROADSINGLE'                                        \n")
    f.write("TYPE = 'MESH'                                                               \n")
    f.write("$-------------------------------------------------------------------------GLOBAL\n")
    f.write("[GLOBAL]                                                                        \n")
    f.write("OUTBOUND_SAFE = 'TRUE'                                                          \n")
    f.write("EVENT_CHECK = 'TRUE'                                                            \n")
    f.write("DISTANCE_CALC = 'DYNAMIC_STEP'                                                  \n")
    f.write("FRICTION = 'STANDARD'                                                           \n")
    f.write("MESH_CHECK = 'FALSE'                                                            \n")
    f.write("ORIGIN_X = 0                                                                  \n"  )
    f.write("ORIGIN_Y = 0                                                                  \n"  )
    f.write("ORIGIN_Z = 0                                                                  \n"  )
    f.write("ORIGIN_A3 = 0                                                                   \n"  )
    f.write("MESH_LOOKUP_CELL_SIZE = 1                                                       \n")
    f.write("MESH_LOOKUP_ZTOL = 0.1                                                          \n")
    f.write("SMOOTHING_TIME = 0.1                                                            \n"  )
    f.write("MATERIALS_MODE = 1                                                            \n"  )
    f.write("[NODES]                                                                         \n")
    f.write("{ id  x_coord  y_coord  z_coord   }                                             \n")
    # write nodes
    for i in xrange(0,len(nodes)):
        node = nodes[i]
        id = node[0]
        xRF = node[1]
        yRF = node[2]
        zRF = node[3]
        # convert to CRT reference
        x = xRF
        y = yRF
        z = zRF
        f.write("%d %f %f %f\n" % (id, x, y, z))
    # write connections
    f.write("$-----------------------------------------------------------------------ELEMENTS\n")
    f.write("[ELEMENTS]                                                                      \n")
    f.write("{ n1  n2  n3  mu   }                                                            \n")
    for i in xrange(0,len(connections)):
        conn = connections[i]
        a = conn[0]
        b = conn[1]
        c = conn[2]
        material = conn[3]
        f.write("%d %d %d %d\n" % (a, b, c, material))
    # write materials
    f.write("$----------------------------------------------------------------------MATERIALS\n")
    f.write("[MATERIALS]                                                                     \n")
    f.write("{ id  mu   }                                                            \n")
    for i in xrange(0,len(materials)):
        object_name = materials[i]
        mu  = 1.0
        f.write("%d %f $-- %s\n" % (i, mu, object_name))

# ################ #
# main entry point #
# ################ #

objfilename = sys.argv[1]
rdffilename = sys.argv[2]

def process(objfilename, rdffilename):
    print 'reading the obj file:', objfilename
    nodes, connections, materials = readObj(objfilename)

    print 'writing the rdf file:', rdffilename
    writeRdf(nodes, connections, materials, rdffilename)

if __name__=='__main__':
    process(objfilename, rdffilename)