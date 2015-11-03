#ifndef SCREEN_RECORDER_WRAPPER_H
#define SCREEN_RECORDER_WRAPPER_H

#include <nan.h>

class ScreenRecorderWrapper : public Nan::ObjectWrap {
 public:
  static void Init(v8::Local<v8::Object> exports);

 private:
  explicit ScreenRecorderWrapper();
  ~ScreenRecorderWrapper();

  static void New(const Nan::FunctionCallbackInfo<v8::Value>& info);
  static void Start(const Nan::FunctionCallbackInfo<v8::Value>& info);
  static void Stop(const Nan::FunctionCallbackInfo<v8::Value>& info);
  static void SetCapturesMouseClicks(const Nan::FunctionCallbackInfo<v8::Value>& info);
  static void SetCapturesCursor(const Nan::FunctionCallbackInfo<v8::Value>& info);
  static void SetCropRect(const Nan::FunctionCallbackInfo<v8::Value>& info);
  static void SetFrameRate(const Nan::FunctionCallbackInfo<v8::Value>& info);
  static void RecordAudio(const Nan::FunctionCallbackInfo<v8::Value>& info);
  static Nan::Persistent<v8::Function> constructor;
  void *pImpl_;
};

#endif
