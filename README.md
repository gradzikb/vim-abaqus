# vim-abaqus
[VIM](http://www.vim.org/) filetype plugin for [Abaqus](http://www.3ds.com/products-services/simulia/) FE solver.

## Introduction

What is Abaqus filetype plugin?

It's just bunch of scripts to speed up work with Abaqus inputdeck file and VIM text editor.

## Main plugin features
- Syntax highlighting
- Folding
- Keyword completion
- Useful commands, functions and mappings

### Syntax highlighting
With color syntax it's easier to navigate through a inputdeck file.

![syntax](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/syntax.gif)

### Folding
Node & element table folding, no more never ending scrolling.

![folding](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/folding.gif)

### Keyword completion
With keyword completion you can in easy way add a new Abaqus keyword or update existing one.

![completion](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/completion.gif)

### Commands
The plugin has many build-in commands to work with data directly for:
- amplitudes
- nodes
- elements

![vimAbaqusAmpCommand](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/commands.gif)

### Commands, functions & mappings
The plugin has couple of great functions to make your work even faster:
- mappings
- comment/uncomment
- data line autoformating
- reference mesh conversion

## Example

The plugin in action you can see [here](https://www.youtube.com/watch?v=cQ0ItTGFwLs&feature=youtu.be).

##Documentation

The plugin has decent [documentation](https://github.com/gradzikb/vim-abaqus/blob/master/doc/abaqus.txt) with detail explanation of all functions and examples.

Please read the documentation before you start using the plugin.

`:help abaqus`

## Installation

[Pathogen](https://github.com/tpope/vim-pathogen)

```
cd ~/.vim/bundle
git clone https://github.com/gradzikb/vim-abaqus
```
## Credits

Part of the plugin is based on VIM Abaqus filtype plugin by Carl Osterwisch.

## License

The GNU General Public License

Copyright &copy; 2014 Bartosz Gradzik

