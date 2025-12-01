## Small utility to validate all contents of `index.json`
##
## Copyright (C) 2025 Trayambak Rai (xtrayambak@disroot.org)
import pkg/[jsony, results, shakar, url]

const PermittedHosts = ["github.com", "gitlab.com"]

type Patch = object
  title, url: string

proc processFile(urls: seq[Patch]): bool =
  for entry in urls:
    let url = tryParseURL(entry.url)
    if !url:
      echo "Cannot parse URL: " & entry.url & " (" & $url.error() & ')'
      return false

    let urlObj = &url

    if !urlObj.hostname or &urlObj.hostname notin PermittedHosts:
      echo "=> URL is on non-whitelisted host: " & entry.url
      return false

    if urlObj.getSchemeType() != SchemeType.Https:
      echo "=> URL has non-HTTPS protocol scheme: " & entry.url
      return false

    echo "-> OK " & entry.url

  true

proc main() {.inline, noReturn.} =
  let file = readFile("index.json")

  try:
    if not processFile(fromJson(file, seq[Patch])):
      echo "Cannot process all URLs in the index properly."
      quit(QuitFailure)
    else:
      echo "Processed all entries successfully, with no errors."
      quit(QuitSuccess)
  except jsony.JsonError as exc:
    echo "Cannot parse index.json: " & exc.msg
    quit(QuitFailure)

when isMainModule:
  main()
