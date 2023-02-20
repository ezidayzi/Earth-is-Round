generate:
	tuist fetch
	tuist generate

clean:
	rm -rf **/**/**/*.xcodeproj
	rm -rf **/**/*.xcodeproj
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

reset:
	tuist clean
	make clean

regenerate:
	make clean
	tuist generate

ci_generate:
	tuist fetch
	TUIST_CI=1 tuist generate
