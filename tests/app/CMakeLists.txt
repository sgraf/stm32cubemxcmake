package_add_test(app_test app_test.cc)
target_link_libraries(app_test app)
target_include_directories(app_test PRIVATE  "../../src/app")