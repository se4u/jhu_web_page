
push: build
	rsync -avz --chmod=o+rx -p _site/* prastog3@masters1.cs.jhu.edu:~/public_html/

build: sphinx
	jekyll build

serve: sphinx
	jekyll serve -w

servedraft: sphinx
	jekyll serve -w -D

sphinx:
	cd ~/Dropbox; \
	sphinx-apidoc -F -o docs sideprojects/ ; \
	cd docs ; \
	$(MAKE) html ; \
	cp -r _build/html/_static ../se4u_github_io/ ; \
	cat _build/html/understanding_logistic_regression.html | sed 's#_static#/~prastog3/_static#g' > ../se4u_github_io/_posts/2015-07-22-understanding_logistic_regression.html
