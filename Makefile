compile:
	flutter pub global run peanut
	flutter pub get
publish:
	git checkout gh-pages
	git add .
	git commit -m "updated"
	git push origin gh-pages
	git checkout master