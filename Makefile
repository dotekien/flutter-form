compile:
	flutter pub global run peanut
publish:
	git checkout gh-pages
	git add .
	git commit -m "updated"
	git push
	git checkout master