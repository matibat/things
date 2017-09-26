#!/usr/bin/env python3
import math

def resultado(dias):
  for dia in range(1, dias+1):
    print("En el dia %s se deben pagar $%s. Porque %s x 2 = %s" %(dia, 	int(math.pow(2, dia)), (int(math.pow(2, dia))/2), int(math.pow(2, dia))))

resultado(31)
