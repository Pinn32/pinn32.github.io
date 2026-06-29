# Quarto Website — Pinn32

## Reproduce This Site

### Clone the Repository

```bash
git clone https://github.com/pinn32/pinn32.github.io.git
cd pinn32.github.io
```

### Restore Environments 

**Restore R environments**

```r
install.packages("renv")  # if not already installed
renv::restore(lockfile = "envs/renv.lock")
```

**Restore Python environments**

```bash
conda env create -f envs/environment.yml
conda activate dv-env
```

**Optional: verify Python environment**

```bash
quarto check jupyter
# Output:
# Path: /path/to/your/envs/dv-env/bin/python
```

### Local Preview

```bash
quarto preview
```

### Optional: Deploying to GitHub Pages

```bash
quarto publish gh-pages
```