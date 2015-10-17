#include "ScreenRecorderWrapper.h"
#import "ScreenRecorder.h"

struct Impl {
  ScreenRecorder *recorder;
};

Nan::Persistent<v8::Function> ScreenRecorderWrapper::constructor;

ScreenRecorderWrapper::ScreenRecorderWrapper(): pImpl_(new Impl) {}

ScreenRecorderWrapper::~ScreenRecorderWrapper() {}

void ScreenRecorderWrapper::Init(v8::Local<v8::Object> exports) {
  Nan::HandleScope scope;

  // Prepare constructor template
  v8::Local<v8::FunctionTemplate> tpl = Nan::New<v8::FunctionTemplate>(New);
  tpl->SetClassName(Nan::New("ScreenRecorder").ToLocalChecked());
  tpl->InstanceTemplate()->SetInternalFieldCount(1);

  // Prototype
  Nan::SetPrototypeMethod(tpl, "start", Start);
  Nan::SetPrototypeMethod(tpl, "stop", Stop);
  Nan::SetPrototypeMethod(tpl, "setCapturesMouseClicks", SetCapturesMouseClicks);
  Nan::SetPrototypeMethod(tpl, "setCapturesCursor", SetCapturesCursor);
  Nan::SetPrototypeMethod(tpl, "setCropRect", SetCropRect);
  Nan::SetPrototypeMethod(tpl, "setFrameRate", SetFrameRate);

  constructor.Reset(tpl->GetFunction());
  exports->Set(Nan::New("ScreenRecorder").ToLocalChecked(), tpl->GetFunction());
}

void ScreenRecorderWrapper::New(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  if (info.IsConstructCall()) {

    if (info.Length() < 1) {
      Nan::ThrowTypeError("Wrong number of arguments");
      return;
    }

    if (!info[0]->IsString()) {
      Nan::ThrowTypeError("Wrong arguments");
      return;
    }

    v8::String::Utf8Value utf8(info[0]->ToString());

    NSString *outputPath = [NSString stringWithUTF8String:*utf8];
    ScreenRecorder *recorder = [[ScreenRecorder alloc] initWithPath:outputPath];

    ScreenRecorderWrapper *obj = new ScreenRecorderWrapper();
    ((Impl*)obj->pImpl_)->recorder = recorder;

    obj->Wrap(info.This());
    info.GetReturnValue().Set(info.This());
  } else {
    Nan::ThrowTypeError("You must call new ScreenRecorder");
  }
}

void ScreenRecorderWrapper::Start(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  ScreenRecorderWrapper *obj = ObjectWrap::Unwrap<ScreenRecorderWrapper>(info.Holder());
  [((Impl*)obj->pImpl_)->recorder start];
}

void ScreenRecorderWrapper::Stop(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  ScreenRecorderWrapper *obj = ObjectWrap::Unwrap<ScreenRecorderWrapper>(info.Holder());
  [((Impl*)obj->pImpl_)->recorder stop];
}

void ScreenRecorderWrapper::SetCapturesMouseClicks(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  bool capturesMouseClicks = info[0]->IsUndefined() ? false : info[0]->BooleanValue();
  ScreenRecorderWrapper *obj = ObjectWrap::Unwrap<ScreenRecorderWrapper>(info.Holder());
  [((Impl*)obj->pImpl_)->recorder setCapturesMouseClicks:capturesMouseClicks];
}

void ScreenRecorderWrapper::SetCapturesCursor(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  bool capturesCursor = info[0]->IsUndefined() ? false : info[0]->BooleanValue();
  ScreenRecorderWrapper *obj = ObjectWrap::Unwrap<ScreenRecorderWrapper>(info.Holder());
  [((Impl*)obj->pImpl_)->recorder setCapturesCursor:capturesCursor];
}

void ScreenRecorderWrapper::SetCropRect(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  if (info.Length() < 4) {
    Nan::ThrowTypeError("Wrong number of arguments");
    return;
  }

  double x = info[0]->NumberValue();
  double y = info[1]->NumberValue();
  double width = info[2]->NumberValue();
  double height = info[3]->NumberValue();

  ScreenRecorderWrapper *obj = ObjectWrap::Unwrap<ScreenRecorderWrapper>(info.Holder());
  [((Impl*)obj->pImpl_)->recorder setCropRect:CGRectMake(x, y, width, height)];
}

void ScreenRecorderWrapper::SetFrameRate(const Nan::FunctionCallbackInfo<v8::Value>& info) {
  if (info.Length() < 1) {
    Nan::ThrowTypeError("Wrong number of arguments");
    return;
  }

  int frameRate = info[0]->NumberValue();

  ScreenRecorderWrapper *obj = ObjectWrap::Unwrap<ScreenRecorderWrapper>(info.Holder());
  [((Impl*)obj->pImpl_)->recorder setFrameRate:frameRate];
}
