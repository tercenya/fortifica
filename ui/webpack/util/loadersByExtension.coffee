extsToRegExp = (exts) ->
  new RegExp('\\.(' + exts.map((ext) ->
    ext.replace /\./g, '\\.'
  ).join('|') + ')(\\?.*)?$')

loadersByExtension = (obj) ->
  loaders = []
  Object.keys(obj).forEach (key) ->
    exts = key.split('|')
    value = obj[key]
    entry =
      extensions: exts
      test: extsToRegExp(exts)
    if Array.isArray(value)
      entry.loaders = value
    else if typeof value == 'string'
      entry.loader = value
    else
      Object.keys(value).forEach (valueKey) ->
        entry[valueKey] = value[valueKey]
        return
    loaders.push entry
    return

  return loaders

module.exports = loadersByExtension
