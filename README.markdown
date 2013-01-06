# sensible.vim

Think of sensible.vim as one step above `'nocompatible'` mode: a universal
set of defaults that (hopefully) everyone can agree on.

* If you're new to Vim, you can install this as a starting point, rather than
  copying some random vimrc you found.
* If you're pair programming and you can't agree on whose vimrc to use, this
  can be your neutral territory.
* If you're administrating a server with an account that's not exclusively
  yours, you can `scp` this up to make things a bit more tolerable.
* If you're troubleshooting a plugin and need to rule out interference from
  your vimrc, having this installed will ensure you still have some basic
  amenities.

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tpope/vim-sensible.git

## Features

See the [source][] for the authoritative list of features.  (Don't worry, it's
mostly `:set` calls.)  Here's a taste:

* `'backspace'`: Backspace through anything in insert mode.
* `'incsearch'`: Start searching before pressing enter.
* `'listchars'`: Show trailing whitespace.
* `'scrolloff'`: Always show at least one line above/below the cursor.
* `'directory'`: Dump swap files under `~/.cache/vim/swap` (only if that
  directory already exists).  Also `'backupdir'` and `'undodir'`.  Try
  `mkdir -p ~/.cache/vim/{swap,backup,undo}`.
* `nmap Y y$`: Make `Y` behaves like `C` and `D`.
* `runtime! macros/matchit.vim`: Load the version of matchit.vim that ships
  with Vim.

[source]: https://github.com/tpope/vim-sensible/master/plugin/sensible.vim

## Contributing

I want this to be a plugin nobody objects to installing.  [Let me know][GitHub
issues] if you have any objections to *anything*.  There are a handful of
settings I figured *might* be controversial, but I included anyways, just to
settle the question once and for all.  It won't take much persuasion for me to
remove them.  Everything else is negotiable.

Feel free to ask a question if you're not sure why I've set something, as I
haven't put much effort into documenting that.

I'm a stickler for [commit messages][], so if you send me a pull
request with so much as superfluous period in the subject line, I will
close it without so much as a second thought, and save my precious attention
for someone who can actually follow directions.

[GitHub issues]: http://github.com/tpope/vim-sensible/issues
[commit messages]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

## Self-Promotion

Like sensible.vim? Follow the repository on
[GitHub](https://github.com/tpope/vim-sensible). And if
you're feeling especially charitable, follow [tpope](http://tpo.pe/) on
[Twitter](http://twitter.com/tpope) and
[GitHub](https://github.com/tpope).

This pairs great with [sleuth.vim](https://github.com/tpope/vim-sleuth).

## License

Copyright © Tim Pope.  Distributed under the same terms as Vim itself.
See `:help license`.
