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
* `'listchars'`: Makes `:set list` (visible whitespace) prettier.
* `'scrolloff'`: Always show at least one line above/below the cursor.
* `nmap Y y$`: Make `Y` behave like `C` and `D`.
* `runtime! macros/matchit.vim`: Load the version of matchit.vim that ships
  with Vim.

[source]: https://github.com/tpope/vim-sensible/tree/master/plugin/sensible.vim

## FAQ

> How can I see what this plugin actually does?

The [source][] is authoritative.  Use `:help 'option'` to see the
documentation for an option.  If you install [scriptease.vim][], you can press
`K` on an option (or command, or function) to jump to its documentation.

[scriptease.vim]: https://github.com/tpope/vim-scriptease

> How can I override a setting?

Normally, sensible.vim loads after your vimrc, making it a bit tricky to
override (although you could use `after/plugin/sensible.vim`).  If you want to
load it earlier, add the following line to you vimrc, then put your overrides
below.

    runtime! plugin/sensible.vim

Feel free to [let me know][GitHub issues] which setting you object to, so I
can reassess whether it makes sense to include it.

> What's with these `.*.un~` files?

Basically, they make it so that you can undo things that happened in a
previous invocation of Vim.  See `:help undo-persistence` for details.  If you
don't like them strewn all over the file system, you have a couple of options:

1.  Provide your own preferred location in `'undodir'`:

        set undodir^=~/.vim/undo

2.  Disable them entirely:

        if has('persistent_undo')
          set noundofile
        endif

You can also just globally ignore them in your SCM of choice.  That's what I
do.

## Contributing

I want this to be a plugin nobody objects to installing.  [Let me
know][GitHub issues] if you have any objections to *anything*.  There are a
handful of settings I figured *might* be controversial, but I included
anyways, just to settle the question once and for all.  It won't take much
persuasion for me to remove them.  Everything else is negotiable.

Feel free to ask a question if you're not sure why I've set something, as I
haven't put much effort into documenting that.

I'm a stickler for [commit messages][], so if you send me a pull request with
so much as a superfluous period in the subject line, I will close it without
so much as a second thought, and save my precious attention for someone who
can actually follow directions.

[GitHub issues]: http://github.com/tpope/vim-sensible/issues
[commit messages]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

## Self-Promotion

Like sensible.vim? Follow the repository on
[GitHub](https://github.com/tpope/vim-sensible) and vote for it on
[vim.org](http://www.vim.org/scripts/script.php?script_id=4391). And if
you're feeling especially charitable, follow [tpope](http://tpo.pe/) on
[Twitter](http://twitter.com/tpope) and
[GitHub](https://github.com/tpope).

This pairs great with [sleuth.vim](https://github.com/tpope/vim-sleuth).

## License

Copyright © Tim Pope.  Distributed under the same terms as Vim itself.
See `:help license`.
