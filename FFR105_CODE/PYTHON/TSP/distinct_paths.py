print("Finding Hamiltonian Paths----")


def product(*args, repeat=1):
    # product('ABCD', 'xy') --> Ax Ay Bx By Cx Cy Dx Dy
    # product(range(2), repeat=3) --> 000 001 010 011 100 101 110 111
    pools = [tuple(pool) for pool in args] * repeat
    result = [[]]
    for pool in pools:
        tmp = []
        for r in result:
            for p in pool:
                tmp.append(r + [p])
        result = tmp
    for prod in result:
        yield tuple(prod)


def permutations(iterable, r=None):
    pool = tuple(iterable)
    n = len(pool)
    r = n if r is None else r
    for indices in product(range(n), repeat=r):
        if len(set(indices)) == r:
            yield tuple(pool[i] for i in indices)


def all_paths(nodes=[1, 2, 3, 4, 5]):
    paths = list(permutations(nodes, r=len(nodes)))
    return paths


def paths2type(pathsNodes, type=int):
    tmp = []
    for i in range(len(pathsNodes)):
        s = ''
        for p in pathsNodes[i]:
            s += str(p)
        tmp.append(type(s))

    paths = tmp

    return paths


def paths2bin(pathsNumber):
    tmp = []
    for p in pathsNumber:
        tmp.append(bin(p))
    paths = tmp

    return paths


def paths_not_flipped(paths):
    tmpPaths = [paths[0]]
    paths = paths[1:]
    while paths:
        t = paths[0]
        paths = paths[1:]
        isFlipt = False
        for tp in tmpPaths:
            if t == tp[::-1]:
                isFlipt = True
        if not isFlipt:
            tmpPaths.append(t)

    paths = tmpPaths
    return paths

def paths_not_cycling(pathsStr):
    tmpPathsStr = [pathsStr[0]]
    pathsStr = pathsStr[1:]

    while pathsStr:
        t = pathsStr[0]
        pathsStr = pathsStr[1:]
        tt = t + t
        isCycling = False
        for tp in tmpPathsStr:
            if tt.count(tp) != 0 :
                isCycling = True
        if not isCycling:
            tmpPathsStr.append(t)

    pathsStr = tmpPathsStr

    return pathsStr

def paths_not_cycling_or_flipt_cycling(pathsStr):
    tmpPathsStr = [pathsStr[0]]
    pathsStr = pathsStr[1:]

    while pathsStr:
        t = pathsStr[0]
        pathsStr = pathsStr[1:]
        tt = t + t
        isCycling = False
        for tp in tmpPathsStr:
            if tt.count(tp) != 0 or tt[::-1].count(tp) != 0:
                isCycling = True
        if not isCycling:
            tmpPathsStr.append(t)

    pathsStr = tmpPathsStr

    return pathsStr


print('ALL PATHS')
N = 4
paths = all_paths(range(1,N+1))
pathsNodesStr = paths2type(paths, str)
print(pathsNodesStr)
print(len(pathsNodesStr))
print('PATHS NOT FLIPT')
pathsNodesStr = paths_not_flipped(pathsNodesStr)
print(pathsNodesStr)
print(len(pathsNodesStr))
print('PATHS NOT CYCLING')
pathsNodesStr = paths_not_cycling(pathsNodesStr)
print(pathsNodesStr)
print(len(pathsNodesStr))
print('PATHS NOT FLIPT AND CYCLING')
pathsNodesStr = paths_not_cycling_or_flipt_cycling(pathsNodesStr)
print(pathsNodesStr)
print(len(pathsNodesStr))
