#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

# Objetivo: comparar la dos versiones distintas de la solucion del problema.
#
# Problema: determinar cantidad de números pares de tres cifras distintas que existen.

posiblesCaracteres = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] #  [1, 2, 3, 4, 5, 6, 7, 8, 9]
posiblesPares =      ["2", "4", "6", "8"]                          #  [2, 4, 6, 8]
posiblesImpares=     ["1", "3", "5", "7", "9"]

def sinValor(lista, valor):
  salida = []
  for x in lista:
    if x != valor:
      salida.append(x)
  return salida

def fede():
  coincidencias = []
  cantidad = 0
  caracteres = ["0", "0", "0"] # [a, b, c]

  # c = 0
  for b in posiblesCaracteres:
    caracteres[1] = b
    for a in sinValor(posiblesCaracteres, b):
      caracteres[0] = a
      coincidencias.append("".join(caracteres))
      cantidad += 1

  # b = 0
  caracteres[1] = "0"

  for c in posiblesPares:
    caracteres[2] = c
    for a in sinValor(posiblesCaracteres, c):
      caracteres[0] = a
      coincidencias.append("".join(caracteres))
      cantidad += 1

  # a, b, c != "0"

  for c in posiblesPares:
    caracteres[2] = c
    for b in sinValor(posiblesCaracteres, c):
      caracteres[1] = b
      for a in sinValor(sinValor(posiblesCaracteres, c), b):
        caracteres[0] = a
        coincidencias.append("".join(caracteres))
        cantidad += 1
  
  return sorted(coincidencias), cantidad  

def mati():
  coincidencias = []
  cantidad = 0

  for a in posiblesPares:
    for b in sinValor([*posiblesPares, "0"], a):
      for c in sinValor(sinValor([*posiblesPares, "0"], a), b):
        coincidencias.append("".join([a, b, c]))
        cantidad += 1
    for b in posiblesImpares:
      for c in sinValor([*posiblesPares, "0"], a):
        coincidencias.append("".join([a, b, c]))
        cantidad += 1

  for a in posiblesImpares:
    for b in sinValor(posiblesImpares, a):
      for c in [*posiblesPares, "0"]:
        coincidencias.append("".join([a, b, c]))
        cantidad += 1
    for b in [*posiblesPares, "0"]:
      for c in sinValor([*posiblesPares, "0"], b): 
        coincidencias.append("".join([a, b, c]))
        cantidad += 1

  return sorted(coincidencias), cantidad


def main():
  coincidenciasFede, cantidadFede = fede()
  coincidenciasMati, cantidadMati = mati()

  if cantidadFede == cantidadMati:
    print("Both has same cardinal.")
  else:
    print("Fede's set cardinal: " + str(cantidadFede))
    print("Mati's set cardinal: " + str(cantidadMati))

  print("#\tFEDE\t\tMATI")
  for i in range(0, max([cantidadFede, cantidadMati])):
    valorFede = coincidenciasFede[i] or "---"
    valorMati = coincidenciasMati[i] or "---"
    print("#" + str(i+1) + "\t" + valorFede + "\t:\t" + valorMati)

if __name__ == "__main__":
  print("[!] Started!")
  main()
  print("[!] End :-)")
  print("\n[!] This all is true, no results were modified e.e")

