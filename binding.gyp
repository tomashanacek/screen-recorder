{
  "targets": [
    {
      "target_name": "addon",
      "sources": [
        "addon.cc",
        "ScreenRecorderWrapper.mm",
        "ScreenRecorder.m"
      ],
      "include_dirs" : [
        "<!(node -e \"require('nan')\")"
      ],
      "conditions": [
        ['OS=="mac"', {
          "link_settings": {
            "libraries": [
              "Foundation.framework",
              "AVFoundation.framework",
            ]
          },
          "xcode_settings": {
            "MACOSX_DEPLOYMENT_TARGET": "10.8"
          },
        }]
      ]
    }
  ]
}
