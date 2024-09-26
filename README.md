# chbr
![chbr_preview](https://github.com/user-attachments/assets/213b8db2-a21e-4f87-a50e-e5e5062205a7)
### A simple git repository navigator written in Ruby!

[Here](https://thestbar.dev/posts/6) more details about the creation of this gem can be found.

# Installation
### Prerequisites
- ruby version >= 3.3.0
- git version >= 2.28.0
- fzf version >= 0.55.0

To install on all platforms:
```bash
gem install chbr
```

[Link to rubygems.org](https://rubygems.org/gems/chbr)

# Usage
While on a git repository type on console:
```bash
chbr
```

### Available flags
| Flag | Info |
| - | - |
| -p, --path PATH | Path to the git repository (Defaults to current repository) |
| -t, --timeout TIMEOUT | Set the timeout for git commands in seconds (Defaults to 5) |
| --disable-reopen | Disable reopening the panel after an action is performed (Defaults to true) |

On the fzf search panel select a branch and type one of the following characters:
- `ENTER` to checkout to selected branch
- `X` to delete selected branch
- `P` to purge/delete all branches except for the selected

# License
Copyright 2024 Stavros Barousis

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
