# Trinity Hymnal Data #
> Provides the data to the trinity hymnal in JSON

## Install ##

```
npm install trinity-hymnal-data --save
```

## Usage ##

```js
var hymns = require('trinity-hymnal-data')
hymns.forEach(function(hymn) {
    console.log(hymn)
})
```

## Scripts ##

**get-hymns**

Uses the `numbers-list.html` file to get a list of hymn urls, and download each hymn's html into the `src/html` folder.

**parse-hymns**

Uses the result from `get-hymns` to build 1) the files in the `src/json` location, and 2) the hymns.json file.
*Note: A small number of the html files had to be doctored to account for differing formats and content.*