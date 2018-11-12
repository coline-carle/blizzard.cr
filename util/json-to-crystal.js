const JsonToCrystal = require('json-to-crystal').JsonToCrystal;
const fs = require('fs');

const json2crystal = new JsonToCrystal()

const filename = process.argv[2];
const contents = fs.readFileSync(filename, 'utf8');
console.log(json2crystal.parse(contents))

