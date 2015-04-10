
push: build
	rsync -avz --chmod=o+rx -p _site/* prastog3@masters1.cs.jhu.edu:~/public_html/
build:
	jekyll build
