#include "ScreenRecorderWrapper.h"

void InitAll(v8::Local<v8::Object> exports) {
  ScreenRecorderWrapper::Init(exports);
}

NODE_MODULE(addon, InitAll)
