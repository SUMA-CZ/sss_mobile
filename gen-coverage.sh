flutter test --coverage &&
lcov --remove coverage/lcov.info "*.g.dart" -o coverage/lcov_cleaned.info &&
genhtml -o coverage coverage/lcov_cleaned.info --no-function-coverage -s -p `pwd` &&
open coverage/index-sort-l.html
