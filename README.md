#vim-abaqus
[VIM](http://www.vim.org/) filetype plugin for [Abaqus](http://www.3ds.com/products-services/simulia/) FE solver.

##Introduction

What is Abaqus filetype plugin?

It's just bunch of VIM scripts to speed up work with Abaqus inputdeck file.

##Main plugin features
- Syntax highlighting
- Folding
- Keyword completion
- Useful commands, functions and mappings

###Syntax highlighting
With color syntax it's easier to navigate through a inputdeck file.

![syntax](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/vimAbaqusColorSyntax.gif)

###Folding
Node & element table folding, no more never ending scrolling.

![folding](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/vimAbaqusFolding.gif)

See VIM documentation for details about foldings: `:help usr_28`

###Keyword completion
With keyword completion you can in easy way add a new Abaqus keyword or update existing one.

![completion](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/vimAbaqusKeywordCompletion.gif)

####Amplitude commands
You can use commands to operate with amplitude data directly in VIM.

![vimAbaqusAmpCommand](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/vimAbaqusAmpCommand.gif)

####Commands, functions & mappings
The plugin has couple of great functions to make your work even faster:
- mappings
- comment/uncomment
- data line autoformating
- reference mesh

Detail list of all of them is in the plugin documentation: `:help abaqus-functions`

##Example

The plugin in action you can see [here](https://github.com/gradzikb/vim-abaqus/wiki/Example).

##Documentation

The plugin has decent [documentation](https://github.com/gradzikb/vim-abaqus/blob/master/doc/abaqus.txt) with detail explanation of all functions and examples.

Please read the documentation before you start using the plugin.

`:help abaqus`

##Installation

[Pathogen](https://github.com/tpope/vim-pathogen)

```
cd ~/.vim/bundle
git clone https://github.com/gradzikb/vim-abaqus
```
## Credits

Part of the plugin is based on VIM Abaqus filtype plugin by Carl Osterwisch.

##License

The GNU General Public License

Copyright &copy; 2014 Bartosz Gradzik

