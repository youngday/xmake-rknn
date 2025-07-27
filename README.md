# xmake-rknn  
use xmake to build rknn model, after xmake-onnxruntime
platform: debian11, rk3588, thanks for coolpi  Laptop, GenBook	
## rknn driver

### rknn-toolkit2
1.5G , large ,git or netdisk 
https://github.com/airockchip/rknn-toolkit2

* or just do it bellow:
```sh
sudo cp /debug/lib/librknnrt.so /usr/lib/
```
## models
you can convert from onnx to rknn model use examples bellow:
https://github.com/airockchip/rknn_model_zoo

NOTE: you can convert from onnx to rknn model use rknn-toolkit2 of version 2.3.2, x64 and aarch64 all support.

* or cp debug.tar.gz to  your debug folder.
## examples 
* rknn_fp16 and i8
target("rknn_yolo11_zoo")
* rknn i8
target("rknn_yolo11_zoo_zero_copy")
* you can test other examples same as rknn_model_zoo.

## xmake

for xmake, please check xmake-example:
https://github.com/youngday/xmake-example

## TODO
* add pose
* send result to web front end
* add video dream

## reference

* https://github.com/airockchip/rknn_model_zoo
* https://github.com/cqu20160901/yolov11_dfl_rknn_Cplusplus
* https://github.com/yuunnn-w/rknn-cpp-yolo

## Thanks !
