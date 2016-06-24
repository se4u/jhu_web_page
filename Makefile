FLAGS := MENTOS_TIMEOUT=16
JEKYLL := $(FLAGS) jekyll
SERVECMD := serve --incremental --watch
push:
	$(MAKE) build; \
	$(MAKE) deploy
# Note that jekyll already copies all symlinked files into the
# _site/res directory. So there is really no need to copy-links
deploy:
	rsync --archive --verbose --compress --copy-links --chmod=o+rx --perms _site/* prastog3@masters1.cs.jhu.edu:~/public_html/

build: sphinx
	$(MAKE) jekyll_build

jekyll_build:
	$(JEKYLL) build --incremental

# Note: The disk on my mac seems to be broken. Auto refresh does not work.
serve:
	$(JEKYLL) $(SERVECMD)

servetrace:
	$(JEKYLL) $(SERVECMD) --trace

servedraft:
	$(JEKYLL) $(SERVECMD) -D

sphinx:
	cd ~/Dropbox; \
	sphinx-apidoc -F -o docs sideprojects/ ; \
	cd docs ; \
	make html ; \
	cp -r _build/html/_static ../se4u_github_io/ ; \
	cat _build/html/understanding_logistic_regression.html | sed 's#_static#/~prastog3/_static#g' > ../se4u_github_io/_posts/2015-07-22-understanding_logistic_regression.html
