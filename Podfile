# Uncomment the next line to define a global platform for your project
platform :ios, '12.2'

target 'iOSMeetup' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  plugin 'cocoapods-keys', {
    :project => "iOSMeetup",
    :keys => [
      "MeetupApiKey"
    ]}
  # Pods for iOSMeetup

  pod 'SwiftyJSON', '5.0'

  target 'iOSMeetupTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOSMeetupUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  #Scripts
  script_phase  :name => 'Swiftlint',
                :script => '$SRCROOT/configurations/Build-Phases/swiftlint.sh',
                :show_env_vars_in_log => true,
                :execution_position => :before_compile
end
