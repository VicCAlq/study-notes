```regex
:s/'\([A-Z,0-9,/, ]*\)': '\([\.,\-,/, ]*\)'/{'\1', '\2'}/g
```

`\(<group>\)` -> Capture group
`[]` -> Match characters and ranges inside brackets
`A-Z`, `0-9`, `/`, ` ` -> Ranges for uppercase letters, numbers, forward slashes and spaces
`\.`, `\-` -> Dots and minuses need to be escaped
`*` -> Matches multiple ocurrences
`\1` -> First capture group
`\2` -> Second capture group
