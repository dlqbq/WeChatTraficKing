const csv = require('csvtojson')
const iconv = require('iconv-lite');

const fs = require('fs');

// const fileStr = fs.readFileSync("./data/1662191134359.csv",{encoding:'binary'});
const fileStr = fs.readFileSync("./data/test.txt",{encoding:'binary'});

 

const buf = new Buffer(fileStr,'binary');

 

const str = iconv.decode(buf,'GBK');

 

console.log(str);
const converter = csv().fromFile("./data/test.txt").then((json) => {
    console.log(json)
})