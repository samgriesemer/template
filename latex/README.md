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
    --variable geometry="margin=1.3in" thompson.md 
    --pdf-engine=xelatex 
    -t latex
    -o thompson.pdf
```
