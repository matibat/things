#!/usr/bin/env python

import os

def main():
  running = True
  while running:
    i = input("Cantidad de muestras: ")
    try:
      i = int(i)
      running = False
    except Exception:
      print("#! Debe ser un numero")

  lista = []
  actual = 1
  anterior = 0
  for index in range(0, i):
    lista.append(str(actual))
    actual = actual + anterior
    anterior = actual - anterior
    actual = actual - anterior

    actual = anterior + actual

  os.system("clear")
  print("##### INICIO #####")
  print("\n".join(lista))

if __name__ == "__main__":
  main()

