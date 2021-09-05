#include "app.h"

#include "gtest/gtest.h"
#include "gmock/gmock.h"

namespace {
TEST(TestApp, Do) {
    App a;
    EXPECT_THAT(a.Do(), testing::Eq(1));
}

}  // namespace

int main(int argc, char** argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}