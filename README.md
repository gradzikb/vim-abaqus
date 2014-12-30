#vim-abaqus
[VIM](http://www.vim.org/) filetype plugin for [Abaqus](http://www.3ds.com/products-services/simulia/) FE solver.

##Introduction

What is Abaqus filetype plugin?

It's set of scripts for VIM to speed up work with Abaqus inputdeck file.

##Main plugin features
- Syntax highlighting
- Folding
- Keyword completion
- Useful commands, functions and mappings

####Syntax highlighting
With color syntax it's easier to navigate through a keyword file.

![vimAbaqusColorSyntax](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/vimAbaqusColorSyntax.gif)

####Folding
Node & element table folding, no more never ending scrolling.

![vimAbaqusFolding](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/vimAbaqusFolding.gif)

####Keyword completion
With keyword completion you can in easy way add a new Abaqus keyword or update existing one.

![vimAbaqusKeywordCompletion](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/vimAbaqusKeywordCompletion.gif)

####Amplitude commands
You can use commands to operate with amplitude data directly in VIM.

![vimAbaqusAmpCommand](https://raw.github.com/wiki/gradzikb/vim-abaqus/gifs/vimAbaqusAmpCommand.gif)

####Commands, functions & mappings
The plugin has couple of great mappings/functions to make your work even faster.

##Example
On a [wiki page](https://github.com/gradzikb/vim-abaqus/wiki/Example) you can see the plugin in action.

##Documentation

The plugin has [documentation](https://github.com/gradzikb/vim-abaqus/blob/master/doc/abaqus.txt) with detail explanation of all functions and examples how to use them.

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

