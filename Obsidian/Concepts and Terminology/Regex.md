ex. `r'([^,]*),\s+([0-9]+)\s+([^,]+),\s+(.*)'`
- `([^,]*),` captures all characters (0 or more) that are not a comma until the next comma
- `\s+([0-9]+)` one or more whitespace, then one or more character (0-9)
- `\s+([^,]+),` one or more whitespace, then everything that is not a komma until the next komma
- `\s+(.*)` one or more whitespace, then zero or more characters (any) until end of string essentially
![[Pasted image 20261101164049.png]]
