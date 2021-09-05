# Pandoc Markdown to PDF
For now, can run the command

```bash
pandoc -N --listings --highlight-style tango --template=pandoc-template.tex <file> --pdf-engine=xelatex -o <output-file>
```

Use the `pandoc-template.tex`. The options:

- `-N`: number the headings
- `--listings`: use the `listings` package for code blocks
    * Faces issues in its current state. The defined `passthrough` command does not
      properly escape everything, namely inline code objects exemplifying commands (it
      seems).
- `--pdf-engine`: for now, set to `xelatex`

## New: closer to default Pandoc w/ kpfonts
The command

```bash
pandoc -N 
    --highlight-style tango 
    --template=../default_mod.tex 
    --variable csquotes 
    --variable geometry="margin=1.3in" 
    --pdf-engine=xelatex 
    -t latex
    thompson.md 
    -o thompson.pdf
```

works well for a start to nice looking documents from Markdown files.

## HW Pandoc template
When specifically compiling homework documents from Markdown files, you can use the
`hw_doc.tex` template:

```bash
pandoc 
    --highlight-style tango 
    --template=../hw_mod.tex 
    --variable csquotes
    --variable geometry="margin=1.3in" 
    --pdf-engine=xelatex 
    -t latex 
    hw.md 
    -o hw.pdf
```

Note that the `-N` option has been removed compared to the previous command. With headers
like "Question 4: ...", the initial number can seem odd. They can be added back with the
flag if desired.
