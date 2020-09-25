compile:
	flutter pub get
	flutter pub global run peanut
publish:
	git checkout gh-pages
	git add .
	git commit -m "updated"
	git push origin gh-pages
	git checkout master