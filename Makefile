FLAGS := MENTOS_TIMEOUT=16
JEKYLL := $(FLAGS) jekyll
SERVECMD := serve # -w
push: build
	rsync -avz --chmod=o+rx -p _site/* prastog3@masters1.cs.jhu.edu:~/public_html/

build: sphinx
	$(JEKYLL) build

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
