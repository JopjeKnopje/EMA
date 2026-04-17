# EMA


# Building
## Dependencies
GLWF3

```bash
apt install libglfw3 libglfw3-dev
```

## Dev tools
### clang-format
[clang-format](https://clang.llvm.org/docs/ClangFormat.html) is part of clang-tools, install with.
```bash
apt install clang-tools
```

### prek
For pre commit hooks I use [prek](https://github.com/j178/prek?tab=readme-ov-file#installation), the following command will install it into `~/.local/bin`
```bash
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/j178/prek/releases/download/v0.2.27/prek-installer.sh | sh
```

### compiledb
I don't want to deal with python versions since its quite annoying on my distro. So I just let [pyenv](https://github.com/pyenv/pyenv) handle that.

This will set the user's python version to `3.13`, you could also use the `pyenv local` command instead of `global`.
```bash
pyenv install 3.13
pyenv global 3.13
```

Then you can use pip, which will now be pointing at python `3.13` to install compiledb.
```bash
pip install compiledb
```


### python tooling

```bash
pip install -r requirements.txt
```



# Resources
- [imgui_explorer](https://pthom.github.io/imgui_explorer/)
