# crossdem MTLD viewer (GitHub Pages)

Static, no-backend version of the notebook widget — pure HTML/JS + Plotly.js,
so it runs directly in the browser with no Python kernel.

## Files
- `index.html` — the interactive page (checkboxes, doc slider, bar/line toggle, median toggle)
- `data.json` — the mtld values + colors per politician, consumed by `index.html`
- `export_data.py` — run once in your notebook to (re)generate `data.json` from `politicians_dfs` / `POL_COLORS`

`data.json` currently in this folder is **sample placeholder data** so you can preview
the page immediately. Replace it with the real export before publishing.

## 1. Generate the real data.json

In your crossdem notebook, after `politicians_dfs` and `POL_COLORS` are built, run:

```python
exec(open("export_data.py").read())
```

(or copy `export_data.py`'s body into a cell). It writes `data.json` in your
notebook's working directory — move/copy it next to `index.html`.

## 2. Put it in a repo

```bash
mkdir crossdem-site && cd crossdem-site
cp /path/to/index.html /path/to/data.json .
git init
git add index.html data.json
git commit -m "Add MTLD viewer"
git branch -M main
git remote add origin git@github.com:<you>/crossdem-site.git
git push -u origin main
```

If you'd rather keep this inside your existing `crossdem` repo, just put
`index.html` + `data.json` in a `docs/` folder there instead (see step 3).

## 3. Turn on GitHub Pages

On GitHub: repo → **Settings** → **Pages** →
- **Source**: "Deploy from a branch"
- **Branch**: `main`, folder `/ (root)` (or `/docs` if you used that layout)
- Save.

GitHub gives you a URL like `https://<you>.github.io/crossdem-site/` within a
minute or two.

## Notes
- Everything runs client-side; `data.json` is fetched via a relative path, so it
  must sit in the same folder as `index.html` (or update the `fetch("data.json")`
  path in the script).
- Sampling uses a small seeded PRNG (mulberry32) instead of `pandas.Series.sample`,
  so the *exact* sampled points won't match the notebook's numpy/pandas RNG —
  but behavior (fixed seed → stable, reproducible sample per doc count) is the same.
- No build step, no dependencies beyond the Plotly CDN script tag already in `index.html`.
