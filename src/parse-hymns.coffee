fs = require 'fs'
Entities = require('html-entities').AllHtmlEntities;

entities = new Entities()
src = __dirname + '/html/'
dest = __dirname + '/json/'
names = fs.readdirSync src
list = []

process = ->
  # Prepare HTML to be processed.
  [name] = arguments
  html = fs.readFileSync "#{src}/#{name}", "utf8"
  START = "<h1>Trinity Hymnal</h1>"
  END = "<div class=\"printMe\">"
  # END = "<h3 class=\"divider\">"
  sttIdx = html.indexOf START
  endIdx = html.indexOf END
  mainHtml = html.substr sttIdx, endIdx - sttIdx
  mainHtml = entities.decode(mainHtml)
  # console.log mainHtml

  try
    # Use special char to break up title/tune section.
    [Title, Tune] = mainHtml.match(/h3>(.*)<\/h3/)[1].split /\s*—\s*/

    # FIX THIS
    Author = ""
    line = mainHtml.match(/<p>Author:(.*)<.p>/y)
    if line
      Author = line[1]

    # [line, HymnNumber, content] = mainHtml.match(/Trinity\sHymnal,.*([0-9]+)([^]*)<.p>\n\n<h3/m)
    [line, HymnNumber, content] = mainHtml.match(/Trinity\sHymnal,..([0-9]+)<br.+>([^]*)<.p>\n\n<h3/m)
    lyrics = content.split /\s*<br.*>\s/

    Lyrics = lyrics.join('\n').trim()
    [FirstLine] = Lyrics.split(/\n/)

    hymn = {
      title: Title
      author: Author
      tune: Tune
      number: HymnNumber
      lyrics: Lyrics
      first_line: FirstLine
    }
    hymnJson = JSON.stringify hymn, null, '  '
    fs.writeFileSync dest + name + '.json', hymnJson
    list.push hymn

  catch error
    console.log 'failed on: ' + name
    console.log  error


for name in names
  process name

fs.writeFileSync __dirname + '/../hymns.json', JSON.stringify list, null, '  '
