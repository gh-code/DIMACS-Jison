# DIMACS Jison

[DIMACS format](http://www.domagoj-babic.com/uploads/ResearchProjects/Spear/dimacs-cnf.pdf) is a file format for satisfiability problems. [Jison](https://github.com/zaach/jison) uses Bison grammers to create a Javascript parser. This is a simple and extensible CNF parser not just for Javascript.

## Installation

If you use Javascript, just download `dimacs.js`.

### In Node.js

```javascript
let parser = require('./dimacs');

let cnf = `
p cnf 3 3
-1 -2 3 0
1 -3 0
2 -3 0`;

let result = parser.parse(cnf);
console.log(result.clauses);
```

### In the browser

```javascript
let cnf = `
p cnf 3 3
-1 -2 3 0
1 -3 0
2 -3 0`;

let result = DIMACS.parse(cnf);
console.log(result.clauses);
```

## Author
Gary Huang <gh.nctu@gmail.com>