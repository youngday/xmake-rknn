set_xmakever("3.0.0")
set_project("xmake-rknn")
set_languages("c++20")
add_rules("mode.debug", "mode.release")

-- xmake project -k compile_commands

add_requires("opencv", {system = true})
add_requires("libsndfile", {system = true})

add_requires("openssl", {alias = "openssl", configs = { options = "OpenSSL:shared=True" }})
add_requires( "yaml-cpp 0.8.0",  "cppzmq 4.10.0", "toml11 4.4.0","quill 10.0","fmt 11.2",
"nlohmann_json 3.12","cli11 2.5","concurrentqueue 1.0.4")
add_requires("stb 2025.03.14","tbb 2022.1.0","libjpeg-turbo 3.1.1")
add_packages("yaml-cpp","toml11","nlohmann_json","fmt","quill","cli11","concurrentqueue")
add_packages("opencv","stb","libjpeg-turbo","libsndfile")

-- Update these paths to point to the correct version
add_links("src/rknn/runtime/RK3588/Linux/librknn_api/aarch64/librknn_api.so")  -- or whatever version you need
add_links("src/rknn/runtime/RK3588/Linux/librknn_api/aarch64/librknnrt.so")
add_links("src/rknn/3rdparty/librga/Linux/aarch64/librga.so")
add_includedirs("src/rknn/runtime/RK3588/Linux/librknn_api/aarch64")
add_includedirs("src/rknn/runtime/RK3588/Linux/librknn_api/include")
add_includedirs("src/rknn/3rdparty/librga/include")

add_files("src/rknn/utils/*.c")
add_includedirs("src/rknn/utils")
add_includedirs("src")
-- sudo apt-get install libtbb-dev
--  sudo apt install libsndfile1-dev 
-- sudo apt-get install libturbojpeg0-dev
add_linkdirs("/usr/lib/aarch64-linux-gnu")
add_links("tbb")
-- add_links("sndfile1")
-- add_links("turbojpeg0")


add_includedirs("src/utils")
add_files("src/utils/*.cpp")
add_includedirs("src/")

   
target("rknn_yolo11_zoo")
    set_kind("binary")
    add_files("src/rknn_yolo11_zoo/src/yolo11.cc")
    add_files("src/rknn_yolo11_zoo/*.cc")
    add_includedirs("src/rknn_yolo11_zoo/include")
target("rknn_yolo11_zoo_zero_copy")
    set_kind("binary")
    add_defines("ZERO_COPY")
    add_files("src/rknn_yolo11_zoo/src/yolo11_zero_copy.cc")
    add_files("src/rknn_yolo11_zoo/*.cc")
    add_includedirs("src/rknn_yolo11_zoo/include")







-- Add a custom target to generate compile_commands.json
target("generate_compile_commands")
    set_kind("phony") -- A phony target that doesn't produce a build output
    on_run(function (target)
        os.exec("xmake project -k compile_commands")
    end)    