#include <stdio.h>
#include <stdlib.h>
#include <bitset>
#include <iostream>
#include <iomanip>


/*
 def find_paths(graph):
    cycles = []
    for startnode in graph:
        for endnode in graph:
            newpaths = find_all_paths(graph, startnode, endnode)
            for path in newpaths:
                if (len(path) == len(graph)):
                    cycles.append(path)
    return cycles
 */


int main() {

    std::bitset<8ul> x;
    for (int n = 0; n < 10; n++) {
        x = std::bitset<8>(n);
        for (int i = x.size() - 1; i >= 0; i--) {
            std::cout << x[i];
        }
        std::cout<< std::endl;
    }
    return 0;
}