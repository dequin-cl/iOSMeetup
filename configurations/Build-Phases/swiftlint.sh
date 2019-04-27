if [[ -z "${RUNNING_FASTLANE_ENV}" ]]; then
  	## We are not running under fastlane
	if which swiftlint >/dev/null; then
    	swiftlint autocorrect --config "${SRCROOT}/configurations/swiftlint.yaml"
	else
    	echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    	echo "warning: o pegate un> brew install swiftlint"
	fi
fi