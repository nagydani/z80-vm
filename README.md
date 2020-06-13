# z80-vm

Z80 implementation of seedling, first written in assembler. If it works, it 
will be re-written in itself.

## Function naming convention

Only prepend the part of the (input) type to the label that can be polymorphic

## Comment conventions

`CAN` followed by possible side effects

`RETURNS` followed by return type

`EXITS` if changes the stack frame

Type identifiers are optionally followed by `:` and a label
