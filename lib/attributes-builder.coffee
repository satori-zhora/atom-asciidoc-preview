
module.exports =
  makeAttributes: ->
    attributes =
      defaultAttributes: atom.config.get 'asciidoc-preview.defaultAttributes'
      numbered: sectionNumbering()
      skipFrontMatter: if atom.config.get 'asciidoc-preview.frontMatter' then '' else 'skip-front-matter'
      showTitle: if atom.config.get 'asciidoc-preview.showTitle' then 'showtitle' else 'showtitle!'
      compatMode: if atom.config.get 'asciidoc-preview.compatMode' then 'compat-mode=@' else ''
      forceExperimental: if atom.config.get 'asciidoc-preview.forceExperimental' then 'experimental' else ''
      tocType: calculateTocType()
      safeMode: atom.config.get 'asciidoc-preview.safeMode' or 'safe'
      opalPwd: window.location.href

calculateTocType = ->
  tocType = atom.config.get 'asciidoc-preview.tocType'
  if tocType is 'none'
    ''
  # NOTE: 'auto' (blank option in asciidoctor) is currently not supported but
  # this section is left as a reminder of the expected behaviour
  else if tocType is 'auto'
    'toc=toc! toc2!'
  else
    "toc=#{tocType} toc2!"

sectionNumbering = ->
  numberedOption = atom.config.get 'asciidoc-preview.sectionNumbering'
  if numberedOption is 'always-enabled'
    'sectnums'
  else if numberedOption is 'always-disabled'
    'sectnums!'
  else if numberedOption is 'enabled-by-default'
    'sectnums=@'
  else
    ''
