include(${CMAKE_CURRENT_LIST_DIR}/common.cmake)

set(ACTUAL_DUMP ${CMAKE_CURRENT_BINARY_DIR}/${TEST_NAME})

PrepareTest(VERONAM_FLAGS EXPECTED_DUMP ACTUAL_DUMP)

execute_process(
  COMMAND ${MLIRGEN} ${TEST_FILE} -o -
  OUTPUT_FILE ${ACTUAL_DUMP}/mlir.txt
  RESULT_VARIABLE EXIT_CODE)

if(NOT ${EXIT_CODE} EQUAL 0)
  file(READ ${ACTUAL_DUMP}/mlir.txt ERROR_MESSAGES)
  message(STATUS "OUTPUT:\n${ERROR_MESSAGES}")
  message(FATAL_ERROR " ${MLIRGEN} exited with error code ${EXIT_CODE}")
endif()

if(EXPECTED_DUMP)
  CheckDump(${EXPECTED_DUMP} ${ACTUAL_DUMP})
endif()
