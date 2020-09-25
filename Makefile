compile:
	flutter pub global run peanut
publish: compile
	git checkout gh-pages
	git add .
	git commit -m "updated"
	git push origin gh-pages
	git checkout master
	flutter pub get