req = require 'request'
fs = require 'fs'

html = fs.readFileSync __dirname + '/numbers-list.html', 'utf8'

stripped = html.match(/START.*\s(.*)\s.*END/)

# Ensure main section identified.
# console.log stripped[1]

lines = stripped[1].replace(/<\li>/g, '\n')

# Ensure split worked.
# console.log lines.split('\n')

items = lines.split('\n')

items.shift()

# Ensure entires are solid.
# console.log items[0]

hymns_urls = []
items.forEach (item)->
  data_match = item.match /[0-9]+\..*href="(.*_id=[0-9]+)"/
  hymns_urls.push data_match[1]

# Slowly scrape all the data from the site.

setInterval( ->
  self = this
  url = hymns_urls.shift()
  if not url
    clearInterval self
    return

  # Ensure we have the correct URL.
  # console.log "pinging: https://www.opc.org/#{url}"

  # TODO: Uncomment this to let it run.
  # req "http://www.opc.org/#{url}", (e, r) ->
    # Write to a file that can be processed by a separate script.
    # console.log r.body
    # fs.writeFileSync __dirname + '/html/' + url.replace(/[\?\=]/g, '_'), r.body

  # clearInterval this
, 10)

